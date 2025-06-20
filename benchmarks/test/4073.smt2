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

(declare-sort var1498 0)
(declare-sort var2759 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2759-init () var2759)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2759 String) void)
(declare-const null-var1498 var1498)
(declare-const null-Int Int)
(declare-const var921 var1498) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var921 null-var1498)))
(declare-const var3457 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3457 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (not (>= var3457 0))) ; Negate: Cond: i0 >= 0  
(define-const var3535 var2759 var2759-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var1530 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1530)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1530!1 String)
(assert (= var1530!1 ""))
(assert true)
(define-const var2509 String (append/672562846 var1530!1 "delta ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("delta ") 
(declare-const var1530!2 String)
(assert (= var1530!2 (str.++ var1530!1 "delta ")))
(assert true)
(define-const var2965 String (append/-1001720160 var2509 var3457)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2509!1 String)
(assert (str.prefixof var2509 var2509!1))
(assert true)
(define-const var3242 String (append/672562846 var2965 " < 0")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0") 
(declare-const var2965!1 String)
(assert (= var2965!1 (str.++ var2965 " < 0")))
(assert true)
(define-const var1149 String (toString/-2075883882 var3242)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3535 var1149)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var3535!1 var2759)
(declare-const var1149!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var2759-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1498=org.apache.dubbo.common.utils.AtomicPositiveInteger, var921=r0, var3457=i0, var2759=java.lang.IllegalArgumentException, var3535=$r2, var1530=$r3, var2509=$r4, var2965=$r5, var3242=$r6, var1149=$r7}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var1498, r0=var921, i0=var3457, java.lang.IllegalArgumentException=var2759, $r2=var3535, $r3=var1530, $r4=var2509, $r5=var2965, $r6=var3242, $r7=var1149}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("delta ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 2