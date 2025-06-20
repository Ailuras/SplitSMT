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

(declare-sort var2993 0)
(declare-sort var3132 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3132-init () var3132)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3132 String) void)
(declare-const null-var2993 var2993)
(declare-const null-Int Int)
(declare-const var2658 var2993) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var2658 null-var2993)))
(declare-const var3167 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3167 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (not (>= var3167 0))) ; Negate: Cond: i0 >= 0  
(define-const var2635 var3132 var3132-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var936 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var936)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var936!1 String)
(assert (= var936!1 ""))
(assert true)
(define-const var3480 String (append/672562846 var936!1 "new value ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("new value ") 
(declare-const var936!2 String)
(assert (= var936!2 (str.++ var936!1 "new value ")))
(assert true)
(define-const var2264 String (append/-1001720160 var3480 var3167)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3480!1 String)
(assert (str.prefixof var3480 var3480!1))
(assert true)
(define-const var1556 String (append/672562846 var2264 " < 0")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0") 
(declare-const var2264!1 String)
(assert (= var2264!1 (str.++ var2264 " < 0")))
(assert true)
(define-const var2637 String (toString/-2075883882 var1556)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2635 var2637)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var2635!1 var3132)
(declare-const var2637!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3132-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2993=org.apache.dubbo.common.utils.AtomicPositiveInteger, var2658=r0, var3167=i0, var3132=java.lang.IllegalArgumentException, var2635=$r2, var936=$r3, var3480=$r4, var2264=$r5, var1556=$r6, var2637=$r7}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var2993, r0=var2658, i0=var3167, java.lang.IllegalArgumentException=var3132, $r2=var2635, $r3=var936, $r4=var3480, $r5=var2264, $r6=var1556, $r7=var2637}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("new value ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 2