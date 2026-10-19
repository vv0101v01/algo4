# catmath 數學基礎：定義、定理與公式

本文件以 LaTeX 風格記述 catmath 庫（以 MoonBit 實作）所用之
數學定義、定理與公式。對應模組於括號內標註。

---

## 1. 範疇論（`category.mbt`）

**定義（範疇）**：範疇 $\mathcal{C}$ 由物件類 $\mathrm{Ob}(\mathcal{C})$、
對每對物件 $A,B$ 之態射集 $\mathcal{C}(A,B)$、複合
$\circ$ 與恆等 $\mathrm{id}_A$ 組成，滿足：

$$\forall f:A\to B,\quad \mathrm{id}_B \circ f = f = f \circ \mathrm{id}_A$$
$$\forall f:A\to B,\ g:B\to C,\ h:C\to D,\quad h\circ(g\circ f) = (h\circ g)\circ f$$

**定義（函子）**：$F:\mathcal{C}\to\mathcal{D}$ 滿足
$F(\mathrm{id}_A)=\mathrm{id}_{F(A)}$ 且 $F(g\circ f)=F(g)\circ F(f)$。

**定義（性質）**：$F$ 忠實（faithful）$\iff$ $\forall A,B$，
$F_{A,B}:\mathcal{C}(A,B)\to\mathcal{D}(FA,FB)$ 單射；
滿（full）$\iff$ 滿射；本质满 $\iff$ $\forall D\in\mathcal{D}$，
$\exists C$ 使 $FC\cong D$。

**定理（等价函子）**：$F$ 為等價 $\iff$ $F$ 忠實、滿且本质满
$\iff$ 存在擬逆 $G$ 使 $GF\cong\mathrm{Id}$，$FG\cong\mathrm{Id}$。

**定理（Yoneda 引理）**：對局部小範疇 $\mathcal{C}$、預層
$F:\mathcal{C}^{op}\to\mathbf{Set}$、物件 $A$：

$$\mathrm{Nat}(\mathrm{Hom}(-,A),\,F)\;\cong\;F(A)$$

自然同構由 $\alpha\mapsto\alpha_A(\mathrm{id}_A)$ 給出。

---

## 2. 代數結構（`algebra.mbt`）

**定義（有限群）**：$(G,\cdot,e,{}^{-1})$，$|G|=n$，Cayley 表
$\mathrm{mul}[a][b]=a\cdot b$。

**定理（Lagrange）**：$H\le G\implies |G|=|H|\cdot[G:H]$。

**公式（模運算）**：在 $\mathbb{F}_p$ 上，

$$a^b \bmod p:\quad
\text{平方–乘演算法，}\Theta(\log b)\text{ 次模乘}$$

$$a^{-1}\equiv a^{p-2}\pmod p\quad(\text{Fermat，}p\text{ 素數})$$

**定理（Strassen）**：$n\times n$ 矩陣乘法可經七次遞迴乘法完成：

$$M_k = 7\,M_{k-1}\implies T(n)=O(n^{\log_2 7})\approx O(n^{2.807})$$

**定理（NTT）**：$p=998244353=119\cdot 2^{23}+1$，原根 $g=3$，
長度 $n=2^k$ 之 DFT 可在 $O(n\log n)$ 次模乘內完成，
故多項式乘法 $O(n\log n)$（朴素卷積 $O(n^2)$）。

**定理（Karatsuba）**：$x\cdot y$ 可經三次遞迴乘法完成：
$T(n)=3T(\lceil n/2\rceil)\implies T(n)=O(n^{\log_2 3})\approx O(n^{1.585})$。

**定理（zeta/Möbius 變換）**：偏序集 $(2^{[n]},\subseteq)$ 上，

$$g(S)=\sum_{T\subseteq S}f(T)\quad\text{（SOS DP，}O(n\cdot 2^n)\text{）}$$

$$f(S)=\sum_{T\subseteq S}(-1)^{|S|-|T|}g(T)\quad\text{（Möbius 反演）}$$

---

## 3. 拓撲斯（`topos.mbt`）

**定義（預層拓撲斯）**：小範疇 $\mathcal{C}$ 上之預層範疇
$\widehat{\mathcal{C}}=\mathbf{Set}^{\mathcal{C}^{op}}$，
$F:\mathcal{C}^{op}\to\mathbf{Set}$，限制映射 $F(f):F(B)\to F(A)$（$f:A\to B$）。

**定理（預層條件）**：$F$ 為預層 $\iff$ $F(\mathrm{id})=\mathrm{id}$ 且
$F(g\circ f)=F(f)\circ F(g)$。

**定義（子對象分類器）**：$\Omega$ 為預層，

$$\Omega(f:A\to B)\;=\;\{S\subseteq \mathcal{C}(-,B)\mid S\text{ 為篩，且 }g\in S\Rightarrow f\circ g\in S\}$$

**定理**：$\mathrm{Sub}(F)\cong\mathrm{Nat}(F,\Omega)$，
分類映射 $\chi_S$ 由 $\chi_S(A)(x)=\{f\mid F(f)(x)\in S_A\}$ 給出。

---

## 4. 笛卡爾閉範疇與 STLC（`ccc.mbt`）

**定義（CCC）**：具終物件 $1$、積 $A\times B$（投射 $\pi_1,\pi_2$、配對
$\langle-,-\rangle$）與指數 $B^A$（求值 $\mathrm{ev}:B^A\times A\to B$、
柯里化 $\Lambda$）的範疇，滿足泛性質：

$$\mathrm{Hom}(C\times A,B)\;\cong\;\mathrm{Hom}(C,B^A)$$

**定理（Curry–Howard）**：簡型 λ 演算（STLC）之類型即 CCC 之物件，
項即態射；$\beta$-歸約 $(\lambda x.t)\,u\to t[x:=u]$ 對應求值公理。

**公式（de Bruijn 指標）**：移位與代入帶截止（cutoff）以避免
變元捕獲：

$$\uparrow^k(t)=\text{將自由變元 }i\ge k\text{ 映為 }i+1$$

---

## 5. 乘性線性邏輯與證明網（`linear.mbt`）

**定義（證明結構）**：鏈（link）有向圖——公理鏈（無前提、
兩結論）、張量鏈 $\otimes$（兩前提一結論）、並鏈 $⅋$（兩前提一結論）、
切鏈 cut（兩前提零結論）；每個內部文字出現恰為一鏈之結論與另一鏈
之前提（資源線性）。

**定理（Danos–Regnier 1989，switching 準則）**：切網正確 $\iff$
對每個 $⅋$ 鏈選取其兩前提邊之一刪去（switching），所得圖均為
連通無環（樹）。複雜度 $O(2^p\cdot n)$（$p$ 為 $⅋$ 鏈數）——**指數級**。

**定理（GMM 1993 圖解析／收縮準則；與 DR 等價，Straßburger 2006）**：
切網正確 $\iff$ 可反覆收縮至單一鏈。收縮規則：規則鏈 $L$ 可收縮
$\iff$ 其每個前提文字由「可用」鏈結出（可用 = 尚未併入任何群的
公理鏈，或已收縮群的 head 鏈），且各前提所屬群兩兩相異。
複雜度 $O(n^2)$（Guerrini 1999 改进至 $O(n)$）——**多項式級**。

**定理（切消除）**：切歸約規則

$$\mathrm{cut}(ax,ax)\to\text{合併為單一公理鏈}$$
$$\mathrm{cut}(\otimes(t_1,t_2),\,⅋(p_1,p_2))\;\to\;\otimes(\mathrm{cut}(t_1,p_1),\,\mathrm{cut}(t_2,p_2))$$

保持正確性並終止；歸約至無切正規形。網正確 $\iff$ 其切消除正規形正確。

**定理（sequentialization，Girard 1987）**：正確證明結構可序列化為
序列演算證明；MLL 可證性為 NP 完全（Kanovich 1991）。

---

## 6. 同倫類型論（`homott.mbt`）

**定義（圓 $S^1$）**：高層歸納類型，由 $\mathrm{base}:S^1$ 與
$\mathrm{loop}:\mathrm{base}=\mathrm{base}$ 生成。路徑代數
$\mathrm{Path}(S^1)\cong\mathbb{Z}$：$\mathrm{refl}=0$，
$\mathrm{loop}=1$，連接 $=$ 加法，逆 $=$ 取負。

**定理（編碼–解碼）**：編碼族 $\mathrm{code}:S^1\to\mathcal{U}$，
$\mathrm{code}(\mathrm{base})=\mathbb{Z}$，
$\mathrm{transport}^{\mathrm{code}}(\mathrm{loop},n)=n+1$；

$$\mathrm{encode}(p)=\mathrm{transport}(\mathrm{code},p,0),\quad
\mathrm{decode}(n)=\mathrm{loop}^n$$

encode 與 decode 互逆 $\implies\pi_1(S^1,\mathrm{base})\cong\mathbb{Z}$。

**定理（J 消除）**：$J(x,y,p,C,c):C(x,y,p)$ 滿足計算規則
$J(x,x,\mathrm{refl},C,c)=c$。

**定理（單值性 univalence）**：$(A\simeq B)\simeq(A=B)$——
等價類型之間的等價與類型間等號一一對應（此處作文件記述）。

---

## 7. 導出代數幾何（`derived.mbt`）

**定理（Dold–Kan 對應）**：模擬阿貝爾群範疇 $\simeq$ 非負鏈複形範疇。
正則化 $N_n=\bigcap_{i<n}\ker(d_i)$，微分 $\partial_n=d_n|_{N_n}$，且

$$A_n = N_n\oplus D_n\quad(D_n=\text{退化子模})$$

Moore 複形 $\partial_n=\sum_{i=0}^n(-1)^i d_i$ 與正則化同調同構。

**定理（導出張量積）**：$\mathrm{Tor}_n^R(k,k)=H_n(k\otimes^{\mathbf{L}}_R k)$。

**例（任意無限非零同調）**：$R=k[x]/(x^2)$（對偶數），bar 分解
$B_n=\bar{R}^{\otimes n}\otimes k$，$\bar{R}=\mathrm{span}\{x\}$，
bar 微分 $d(x\otimes\cdots\otimes x)=0$（因 $x^2=0$ 且 $x\cdot k=0$），故

$$\mathrm{Tor}_n^R(k,k)=k\quad\forall n\ge 0$$

——無限多個非零同調群（「任意無限」之實例）。

**對比**：$R=k[x]$ 之 Koszul 分解 $0\to R\xrightarrow{x}R\to k\to 0$：
$\mathrm{Tor}_0=\mathrm{Tor}_1=k$，$\mathrm{Tor}_n=0\ (n\ge2)$。

---

## 8. Operad（`operad.mbt`）

**定義（對稱 operad）**：一族 $P(n)$（帶 $S_n$ 作用）與合成

$$\gamma:P(k)\times P(n_1)\times\cdots\times P(n_k)\to P(n_1+\cdots+n_k)$$

滿足結合律、單位律與等變性。

**例（結合 operad）**：$\mathrm{Assoc}(n)=S_n$，合成
$\gamma(\sigma;\tau_1,\dots,\tau_k)=B(\sigma)\circ(\tau_1\oplus\cdots\oplus\tau_k)$，
其中 $B(\sigma)$ 把第 $m$ 塊送到第 $\sigma(m)$ 塊。

**例（自同態 operad）**：$\mathrm{End}_X(n)=X^{X^n}$，

$$|\mathrm{End}_X(n)|=|X|^{|X|^n}$$

**定理（Stasheff）**：結合多面體 $K_{n+1}$ 的面 $\iff$ 凸 $(n+2)$ 邊形之
非交叉對角線集合；頂點數 = 三角剖分數 = Catalan 數
$C_n=\frac{1}{n+1}\binom{2n}{n}$。

**定理（自由 operad）**：一個二元生成元之自由 operad 在元數 $n$ 有
$F(n)=C_{n-1}$ 個操作（二元樹），遞迴 $F(n)=\sum_{i=1}^{n-1}F(i)F(n-i)$。

---

## 9. 同倫代數（`homotopy_algebra.mbt`）

**定義（$A_\infty$-代數）**：運算 $m_n:A^{\otimes n}\to A$（$n\ge1$）滿足
Stasheff 恆等式（$n=2$ 結合律、$n=3$ 五邊形……）。

**定理（同倫轉移）**：若 $A$ 為 DGA、$h$ 為其收縮同倫
（$dh+hd=\mathrm{id}-\pi$），則同調 $H(A)$ 繼承 $A_\infty$-結構：
$m_1=0$，$m_2=$ 誘導乘積，

$$m_3(x,y,z)=\big[h(xy)z-x\cdot h(yz)\big]$$

$m_n\ (n\ge4)$ 由平面樹求和給出；轉移 $m_n$ 之複雜度
$O(C_{n-1}\cdot n)$（$C_{n-1}$ 為 Catalan 數）。

**定理（Stasheff 五邊形，$n=4$）**：

$$m_3(m_2(x,y),z,w)-m_3(x,m_2(y,z),w)+m_3(x,y,m_2(z,w))$$
$$-m_2(m_3(x,y,z),w)-m_2(x,m_3(y,z,w))=0$$

**例（Massey 積）**：$A=\Lambda(a,b,c)$（$\mathbb{F}_3$ 上外代數），
$d(c)=ab$，$h(ab)=c$；$H(A)=\langle 1,a,b,ac,bc,abc\rangle$，且

$$\langle a,a,b\rangle=m_3^H(a,a,b)=-[ac]\ne 0$$

（$m_4^H=0$ 因 $h^2$ 項消失。）

---

## 10. 群胚與交叉模（`groupoid.mbt`）

**定義（群胚）**：所有態射可逆之範疇。

**定義（交叉模）**：$(G,H,\partial,\triangleright)$，
$\partial:H\to G$ 與作用 $\triangleright$ 滿足
$\partial(h\triangleright g)=\dots$（等變與 Peiffer 恆等式）。

**定理**：連通群胚 $\simeq$ 群作用；$\pi_0=\mathrm{coker}\,\partial$，
$\pi_1=\ker\partial$（對正規交叉模，$\pi_0=\mathrm{Out}$，
$\pi_1=Z$）。

---

## 11. 群上同調（`cohomology.mbt`）

**定義（bar 分解）**：$H^n(G,M)=\mathrm{Ext}^n_{\mathbb{Z}G}(\mathbb{Z},M)$，
上鏈 $C^n=\{f:G^n\to M\}$，上微分

$$d^n f(g_1,\dots,g_{n+1})=g_1\!\cdot\!f(g_2,\dots)+\sum_{i=1}^n(-1)^i f(\dots,g_ig_{i+1},\dots)+(-1)^{n+1}f(g_1,\dots,g_n)$$

**定理（循環群上同調）**：$G=C_m$ 作用平凡時，

$$H^n(C_m,\mathbb{F}_p)=\begin{cases}\mathbb{F}_p,& p\mid m\ (n\ge0)\\ 0,&\text{否则}\ (n\ge1)\end{cases}$$

---

## 12. Galois 範疇（`galois.mbt`）

**定理（有限 $G$-集對應）**：傳遞 $G$-集 $\leftrightarrow$ 子群共軛類，
$G/H\mapsto$ 陪集作用。

**公式**：

$$\mathrm{Aut}_G(G/H)\cong N_G(H)/H,\qquad
\mathrm{Hom}_G(G/H,G/K)=\{xK\mid x^{-1}Hx\subseteq K\}$$

**定理**：Galois 範疇的自同構群 $\mathrm{Aut}(F)\cong G$，
$\tau^b(x)=b\cdot x$；忠实性由作用行向量互異刻劃。

---

## 13. Tannaka 對偶（`tannaka.mbt`）

**定理（Tannaka–Krein）**：緊緻群 $G$ 由其表示範疇
$\mathrm{Rep}(G)$ 連同忘記函子 $\omega$ 重构：

$$G\cong\mathrm{Aut}^{\otimes}(\omega)$$

**公式**：正則表示 $\rho_L(g)$ 之矩陣 $L_g$：$L_g[i][x]=[i=gx]$；
Nat$(\omega,\omega)=$ 左正則表示交換子 $=\{R_a\}$，
$R_a[i][j]=a[j^{-1}i]$；$\mathrm{Aut}^\otimes(\omega)=\{R_g\}$，
$R_g\circ R_h=R_{hg}$，同構 $g\mapsto R_{g^{-1}}$。

---

## 14. 偽函子（`pseudo.mbt`）

**定義（偽函子）**：$F:\mathcal{B}\mathcal{G}\to\mathcal{Cat}$，
配 2-胞 $\phi_{g,h}:F(g)\circ F(h)\Rightarrow F(gh)$ 與
$\phi_g:\mathrm{Id}\Rightarrow F(g)$，滿足相容性（結合五邊形、單位三角形）。

**例**：$G=C_2$，$D=B C_3$，平凡 $\alpha_g$，上循環 $c(1,1)=1$，
餘邊界 $b=(0,2)$（$db(1,1)=4\equiv1\bmod 3$），$H^2(C_2,C_3)=0$
——偽函子可嚴格化。

---

## 15. 平坦函子（`flat.mbt`）

**定義（平坦）**：$F:\mathcal{C}\to\mathcal{D}$ 平坦 $\iff$ $F$ 保拉回。

**定理**：$F$ 平坦 $\iff$ $F$ 的元素範疇（comma 範疇）餘篩選。

---

## 16. 有限拓撲（`topology.mbt`）

**定理（Alexandrov 對應）**：有限拓撲空間 $\cong$ 有限預序集。
專化預序 $x\le y\iff x\in\mathrm{cl}(\{y\})$；開集 $=$ 上集，閉集 $=$ 下集。

**定理**：有限空間間映射連續 $\iff$ 單調（保預序）；
同胚 $\iff$ 預序同構；$T_0\iff$ 預序反對稱。

**公式**：$\mathrm{cl}(S)=\{x\mid\exists s\in S,\ x\le s\}$，
$\mathrm{int}(S)=\overline{\overline{S}^c}^{\,c}$；閉包/內部 $O(n^2)$，
連續性檢驗由 $O(|\tau_X|\cdot n)$ 降至 $O(n^2)$。

---

## 17. 自由函子與伴隨（`free.mbt`）

**定理（萬有性質）**：$\forall$ 幺半群 $A$、$\forall f:X\to U(A)$，
$\exists!$ 幺半群同態 $\tilde f:F(X)\to A$ 使 $U(\tilde f)\circ\eta_X=f$，
其中 $\eta_X:X\to U(F(X))$ 為單位。

**定理（伴隨）**：$F\dashv U$，

$$\mathrm{Hom}_{\mathbf{Mon}}(F(X),A)\;\cong\;\mathrm{Hom}_{\mathbf{Set}}(X,U(A))$$

自然於 $X$ 與 $A$。

**公式（自由群歸一）**：約化詞棧演算法——相鄰互逆生成元相消，
$O(n)$ 時間。

---

## 18. 複雜度降低總表（`algorithms.mbt`）

| 演算法 | naive | 精煉 | 降階 |
|---|---|---|---|
| 模冪 | $O(e)$ | $O(\log e)$ | 平方–乘 |
| 矩陣乘法 | $O(n^3)$ | $O(n^{\log_2 7})$ | Strassen |
| 多項式乘法 | $O(n^2)$ | $O(n\log n)$ | NTT |
| 大數乘法 | $O(n^2)$ | $O(n^{\log_2 3})$ | Karatsuba |
| 子集和 | $O(4^n)$ | $O(n\cdot 2^n)$ | SOS DP |
| 證明網正確性 | $O(2^p\cdot n)$ | $O(n^2)$ | GMM 收縮 |
| 群公理驗證 | $O(n^3)$ | $O(n^2)$ | 模型對照 |
| 動力系統疊代 $f^m(x)$ | $O(m)$ | $O(\log m)$ | 二進制提升 |
| 動力系統環分解 | $O(n^2)$ | $O(n)$ | 剝離+BFS |

**定理（正確性保持）**：每個精煉演算法與其 naive 對照在所有輸入上
回傳相同結果（白盒測試逐案驗證）。

---

## 19. 動力系統（`systems.mbt`）

**定義（有限動力系統）**：$(X,f)$，$X$ 有限集，$f:X\to X$。
範疇論詮釋：動力系統 $=$ 函子 $F:\mathbb{N}\to\mathbf{Set}$
（$\mathbb{N}$ 為加法幺半群視作單物件範疇）；
態射 $h:(X,f)\to(Y,g)$ 為自然變換，即交換圖

$$h\circ f = g\circ h$$

**定理（函數圖結構）**：有限動力系統之相圖由若干「$\rho$ 形」
分量組成（尾 + 環）；每點軌道最終進入唯一環。

**定理（Floyd 龜兔演算法）**：環偵測 $O(\mu+\lambda)$ 時間、
$O(1)$ 空間（$\mu$ 入環前距，$\lambda$ 環長）。

**定理（環分解）**：剝離入度零點（尾）$\to$ 剩餘為環點
$\to$ 環遍歷標號 $\to$ 反向 BFS 標尾長，$O(n)$
（對每點重算軌道的樸素 $O(n^2)$ 降階）。

**定理（自由動力系統）**：$(\mathbb{N},\mathrm{succ})$ 為單點生成
自由系統；$\forall x_0\in X$，$\exists!\,h:\mathbb{N}\to X$，
$h(0)=x_0$，$h(n)=f^n(x_0)$。

**公式（二進制提升）**：跳躍指標 $\mathrm{jump}[k][x]=f^{2^k}(x)$，
預處理 $O(n\log M)$，查詢 $f^m(x)$ 為 $O(\log m)$
（樸素疊代 $O(m)$）。

**公式（Dyn 之積）**：$(X_1,f_1)\times(X_2,f_2)=
(X_1\times X_2,\,f_1\times f_2)$。

---

## 20. 零成本抽象（`zerocost.mbt`）

**定理（零成本抽象，Stroustrup）**：抽象機制不應課予執行期成本。

**機制**：
1. **單態化**：泛型 $\mathrm{fn}[T:\mathrm{Addable}]$ 於編譯期為每個
   具體類型生成特化副本，呼叫靜態綁定。
2. **`#inline`**：小函數於編譯期展開，呼叫開銷為零。
3. **常量摺疊**：純函數作用於字面量之表達式於編譯期求值。

**基準實證**（`bench_wbtest.mbt`）：`generic_sum` 與手寫特化
`int_sum` 之執行時間相同（誤差範圍內）——抽象成本為零。
