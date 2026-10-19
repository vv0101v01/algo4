// bench_wbtest.mbt：複雜度降低的基準測試（moon bench）。
//
// 每組對照：naive 演算法 vs 精煉演算法，
// 展示漸近複雜度的實際效能差距。

///|
/// 星形證明網：k 個並鏈經張量樹匯合（2k 公理 + k 並 + k−1 張量）
fn star_net(k : Int32) -> ProofNet {
  let nodes : Array[NetNode] = []
  for _i in 0..<k {
    nodes.push(mk_axiom())
    nodes.push(mk_axiom())
  }
  for i in 0..<k {
    nodes.push(mk_par(2 * i, 2 * i + 1))
  }
  if k >= 2 {
    nodes.push(mk_tensor(2 * k, 2 * k + 1))
    let mut t = nodes.length() - 1
    for i in 2..<k {
      nodes.push(mk_tensor(t, 2 * k + i))
      t = nodes.length() - 1
    }
  }
  ProofNet::{ nodes, }
}

///|
/// 隨機矩陣（確定性偽隨機，避免執行期隨機性）
fn rand_mat(n : Int32, p : Int32, seed : Int32) -> Mat {
  make_mat(
    n,
    n,
    p,
    Array::makei(n, fn(i) {
      Array::makei(n, fn(j) { (i * n + j + seed * 31) % p })
    }),
  )
}

// 對照 1：模冪——O(log e) vs O(e)

///|
test (b : @bench.T) {
  b.bench(name="pow_mod_refined", fn() { b.keep(pow_mod_steps(3, 100000, 97)) })
  b.bench(name="pow_mod_naive", fn() { b.keep(naive_pow_steps(3, 100000, 97)) })
}

// 對照 2：矩陣乘法的立方增長（n=32/64/128，~8×/倍增）
// Strassen 的乘法步數降階（7^k vs 8^k）見 algorithms_wbtest；
// 函數式實現的配置開銷使實際交叉點在更大 n，故此處
// 以立方增長曲線呈現被降階的複雜度。

///|
test (b : @bench.T) {
  let a32 = rand_mat(32, 97, 1)
  let b32 = rand_mat(32, 97, 2)
  let a64 = rand_mat(64, 97, 1)
  let b64 = rand_mat(64, 97, 2)
  let a128 = rand_mat(128, 97, 1)
  let b128 = rand_mat(128, 97, 2)
  b.bench(name="mat_mul_n32", fn() { b.keep(mat_mul_steps(a32, b32)) })
  b.bench(name="mat_mul_n64", fn() { b.keep(mat_mul_steps(a64, b64)) })
  b.bench(name="mat_mul_n128", fn() { b.keep(mat_mul_steps(a128, b128)) })
}

// 對照 3：多項式乘法——NTT O(n log n) vs 朴素 O(n²)

///|
test (b : @bench.T) {
  let p = 998244353
  let aa = Array::makei(1024, fn(i) { (i * 7 + 3) % p })
  let bb = Array::makei(1024, fn(i) { (i * 5 + 1) % p })
  b.bench(name="poly_mul_naive", fn() {
    b.keep(poly_mul_naive_steps(aa, bb, p))
  })
  b.bench(name="poly_mul_ntt", fn() { b.keep(poly_mul_ntt_steps(aa, bb, p, 3)) })
}

// 對照 4：子集和——SOS DP O(n·2ⁿ) vs 窮舉 O(4ⁿ)

///|
test (b : @bench.T) {
  let f = Array::makei(256, fn(i) { i % 97 })
  b.bench(name="zeta_naive", fn() { b.keep(zeta_naive_steps(f, 97)) })
  b.bench(name="zeta_sos", fn() { b.keep(zeta_steps(f, 97)) })
}

// 對照 5：證明網正確性——GMM 收縮 O(n²) vs DR switching O(2^p·n)

///|
test (b : @bench.T) {
  let net = star_net(10)
  b.bench(name="dr_switching_exponential", fn() {
    b.keep(dr_switching_run(net))
  })
  b.bench(name="gmm_parsing_polynomial", fn() { b.keep(gmm_parsing_steps(net)) })
}

// 對照 6：零成本抽象——泛型單態化 vs 手寫特化

///|
test (b : @bench.T) {
  let xs = Array::makei(1000, fn(i) { i })
  b.bench(name="generic_sum", fn() { b.keep(generic_sum(xs)) })
  b.bench(name="specialized_sum", fn() { b.keep(int_sum(xs)) })
}

// 對照 7：動力系統疊代——二進制提升 O(log m) vs 樸素 O(m)

///|
test (b : @bench.T) {
  let ds = make_dyn(1000, Array::makei(1000, fn(x) { (x + 1) % 1000 }))
  let jt = make_jump(ds, 20)
  b.bench(name="ds_iterate_naive", fn() { b.keep(ds_iterate(ds, 0, 999999)) })
  b.bench(name="ds_iterate_binary_lifting", fn() {
    b.keep(ds_iterate_pow(jt, 0, 999999))
  })
}
