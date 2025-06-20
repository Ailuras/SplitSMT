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

(declare-sort var1621 0)
(declare-sort var3996 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3996-init () var3996)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3996 String) void)
(declare-const null-var1621 var1621)
(declare-const null-Int Int)
(declare-const var1914 var1621) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var1914 null-var1621)))
(declare-const var11 Int) ; Statement: i1 := @parameter0: int 
(assert (not (= var11 null-Int)))
(declare-const var1606 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1606 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (not (>= var1606 0))) ; Negate: Cond: i0 >= 0  
(define-const var1393 var3996 var3996-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var1327 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1327)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1327!1 String)
(assert (= var1327!1 ""))
(assert true)
(define-const var1849 String (append/672562846 var1327!1 "update value ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("update value ") 
(declare-const var1327!2 String)
(assert (= var1327!2 (str.++ var1327!1 "update value ")))
(assert true)
(define-const var3714 String (append/-1001720160 var1849 var1606)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1849!1 String)
(assert (str.prefixof var1849 var1849!1))
(assert true)
(define-const var2636 String (append/672562846 var3714 " < 0")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0") 
(declare-const var3714!1 String)
(assert (= var3714!1 (str.++ var3714 " < 0")))
(assert true)
(define-const var1474 String (toString/-2075883882 var2636)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1393 var1474)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var1393!1 var3996)
(declare-const var1474!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3996-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1621=org.apache.dubbo.common.utils.AtomicPositiveInteger, var1914=r0, var11=i1, var1606=i0, var3996=java.lang.IllegalArgumentException, var1393=$r2, var1327=$r3, var1849=$r4, var3714=$r5, var2636=$r6, var1474=$r7}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var1621, r0=var1914, i1=var11, i0=var1606, java.lang.IllegalArgumentException=var3996, $r2=var1393, $r3=var1327, $r4=var1849, $r5=var3714, $r6=var2636, $r7=var1474}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i1 := @parameter0: int;	i0 := @parameter1: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("update value ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 2