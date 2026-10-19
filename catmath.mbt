///|
/// catmath：以 MoonBit 實作的範疇論與高維代數演算法庫。
///
/// 設計公理：
///   （一）運算邏輯於編譯時經單態化特化——零成本抽象；
///   （二）核心演算法經複雜度精煉（指數→多項式等）；
///   （三）任意無限、高維突破：Tor 的無限週期性、
///        A∞ 同倫轉移、Dold–Kan 對應、HoTT 單值性。
fn main {
  println("catmath: category-theoretic algorithms on MoonBit")
  println("modules: 21  |  tests: moon test  |  benchmarks: moon bench")
  // 編譯期常量摺疊示範（zerocost.mbt）
  let _ = zero_cost_demo()
  // 自由幺半群萬有性質示範（free.mbt）：Z2 上的詞求值
  let zm = FinMonoid::{ order: 2, mul: [[0, 1], [1, 0]], e: 0, name: "Z2", }
  let _ = fm_extend(FreeMonoid::{ alphabet: 2, }, [0, 1], zm, [1, 0, 1])
}
