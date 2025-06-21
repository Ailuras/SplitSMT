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

(declare-sort var1861 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1861 var1861)
(declare-const null-Int Int)
(declare-const var1310 var1861) ; Statement: r1 := @this: com.alibaba.dubbo.container.page.pages.SystemPageHandler 
(assert (not (= var1310 null-var1861)))
(declare-const var669 Int) ; Statement: l14 := @parameter0: long 
(assert (not (= var669 null-Int)))
(define-const var499 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var499)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var499!1 String)
(assert (= var499!1 ""))
(define-const var3593 Int (ite (> var669 86400000) 1 (ite (< var669 86400000) -1 0))) ; Statement: $b0 = l14 cmp 86400000L 
(define-const var1509 Int (cast-from-Int-to-Int var3593)) ; Statement: $i22 = (int) $b0 
 ; Statement: if $i22 <= 0 goto $b1 = l14 cmp 3600000L 
(assert (<= var1509 0)) ; Cond: $i22 <= 0 
(define-const var361 Int (ite (> var669 3600000) 1 (ite (< var669 3600000) -1 0))) ; Statement: $b1 = l14 cmp 3600000L 
(define-const var731 Int (cast-from-Int-to-Int var361)) ; Statement: $i23 = (int) $b1 
 ; Statement: if $i23 <= 0 goto $b17 = l14 cmp 60000L 
(assert (<= var731 0)) ; Cond: $i23 <= 0 
(define-const var1484 Int (ite (> var669 60000) 1 (ite (< var669 60000) -1 0))) ; Statement: $b17 = l14 cmp 60000L 
(define-const var635 Int (cast-from-Int-to-Int var1484)) ; Statement: $i24 = (int) $b17 
 ; Statement: if $i24 <= 0 goto $b19 = l14 cmp 1000L 
(assert (<= var635 0)) ; Cond: $i24 <= 0 
(define-const var2295 Int (ite (> var669 1000) 1 (ite (< var669 1000) -1 0))) ; Statement: $b19 = l14 cmp 1000L 
(define-const var3838 Int (cast-from-Int-to-Int var2295)) ; Statement: $i25 = (int) $b19 
 ; Statement: if $i25 <= 0 goto $b21 = l14 cmp 0L 
(assert (<= var3838 0)) ; Cond: $i25 <= 0 
(define-const var1217 Int (ite (> var669 0) 1 (ite (< var669 0) -1 0))) ; Statement: $b21 = l14 cmp 0L 
(define-const var881 Int (cast-from-Int-to-Int var1217)) ; Statement: $i26 = (int) $b21 
 ; Statement: if $i26 <= 0 goto $r2 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (<= var881 0)) ; Cond: $i26 <= 0 
(assert true)
(define-const var3043 String (toString/-2075883882 var499!1)) ; Statement: $r2 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), cast-from-Int-to-Int=([byte], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1861=com.alibaba.dubbo.container.page.pages.SystemPageHandler, var1310=r1, var669=l14, var499=$r3, var3593=$b0, var1509=$i22, var361=$b1, var731=$i23, var1484=$b17, var635=$i24, var2295=$b19, var3838=$i25, var1217=$b21, var881=$i26, var3043=$r2}
; {com.alibaba.dubbo.container.page.pages.SystemPageHandler=var1861, r1=var1310, l14=var669, $r3=var499, $b0=var3593, $i22=var1509, $b1=var361, $i23=var731, $b17=var1484, $i24=var635, $b19=var2295, $i25=var3838, $b21=var1217, $i26=var881, $r2=var3043}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: com.alibaba.dubbo.container.page.pages.SystemPageHandler;	l14 := @parameter0: long;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$b0 = l14 cmp 86400000L;	$i22 = (int) $b0;	if $i22 <= 0 goto $b1 = l14 cmp 3600000L;	$b1 = l14 cmp 3600000L;	$i23 = (int) $b1;	if $i23 <= 0 goto $b17 = l14 cmp 60000L;	$b17 = l14 cmp 60000L;	$i24 = (int) $b17;	if $i24 <= 0 goto $b19 = l14 cmp 1000L;	$b19 = l14 cmp 1000L;	$i25 = (int) $b19;	if $i25 <= 0 goto $b21 = l14 cmp 0L;	$b21 = l14 cmp 0L;	$i26 = (int) $b21;	if $i26 <= 0 goto $r2 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r2 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 6