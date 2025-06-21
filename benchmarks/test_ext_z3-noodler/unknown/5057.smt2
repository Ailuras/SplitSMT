(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2071 0)
(declare-sort var569 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun left/-373446220 (var2071) var569)
(declare-fun append/-1031950772 (String var569) String)
(declare-fun right/-373446220 (var2071) var569)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2071 var2071)
(declare-const var2974 var2071) ; Statement: r1 := @this: org.apache.dubbo.common.utils.Pair 
(assert (not (= var2974 null-var2071)))
(define-const var1864 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1864)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1864!1 String)
(assert (= var1864!1 ""))
(assert true)
(define-const var3175 String (append/672562846 var1864!1 "(")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(") 
(declare-const var1864!2 String)
(assert (= var1864!2 (str.++ var1864!1 "(")))
(define-const var3522 var569 (left/-373446220 var2974)) ; Statement: $r2 = r1.<org.apache.dubbo.common.utils.Pair: java.lang.Object left> 
(assert true)
(define-const var1992 String (append/-1031950772 var3175 var3522)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3175!1 String)
(assert (str.prefixof var3175 var3175!1))
(assert true)
(define-const var738 String (append/672562846 var1992 ", ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var1992!1 String)
(assert (= var1992!1 (str.++ var1992 ", ")))
(define-const var768 var569 (right/-373446220 var2974)) ; Statement: $r5 = r1.<org.apache.dubbo.common.utils.Pair: java.lang.Object right> 
(assert true)
(define-const var1680 String (append/-1031950772 var738 var768)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var738!1 String)
(assert (str.prefixof var738 var738!1))
(assert true)
(define-const var1852 String (append/-1166366385 var1680 41)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1680!1 String)
(assert (str.prefixof var1680 var1680!1))
(assert true)
(define-const var449 String (toString/-2075883882 var1852)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), left/-373446220=([org.apache.dubbo.common.utils.Pair], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), right/-373446220=([org.apache.dubbo.common.utils.Pair], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2071=org.apache.dubbo.common.utils.Pair, var2974=r1, var1864=$r0, var3175=$r3, var569=java.lang.Object, var3522=$r2, var1992=$r4, var738=$r6, var768=$r5, var1680=$r7, var1852=$r8, var449=$r9}
; {org.apache.dubbo.common.utils.Pair=var2071, r1=var2974, $r0=var1864, $r3=var3175, java.lang.Object=var569, $r2=var3522, $r4=var1992, $r6=var738, $r5=var768, $r7=var1680, $r8=var1852, $r9=var449}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.utils.Pair;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r2 = r1.<org.apache.dubbo.common.utils.Pair: java.lang.Object left>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r5 = r1.<org.apache.dubbo.common.utils.Pair: java.lang.Object right>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1