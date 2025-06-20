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

(declare-sort var2061 0)
(declare-sort var1519 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1519-init () var1519)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1519 String) void)
(declare-const null-var2061 var2061)
(declare-const null-Int Int)
(declare-const var657 var2061) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var657 null-var2061)))
(declare-const var3379 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3379 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (not (>= var3379 0))) ; Negate: Cond: i0 >= 0  
(define-const var1215 var1519 var1519-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var3683 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3683)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3683!1 String)
(assert (= var3683!1 ""))
(assert true)
(define-const var647 String (append/672562846 var3683!1 "delta ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("delta ") 
(declare-const var3683!2 String)
(assert (= var3683!2 (str.++ var3683!1 "delta ")))
(assert true)
(define-const var2312 String (append/-1001720160 var647 var3379)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var647!1 String)
(assert (str.prefixof var647 var647!1))
(assert true)
(define-const var3555 String (append/672562846 var2312 " < 0")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0") 
(declare-const var2312!1 String)
(assert (= var2312!1 (str.++ var2312 " < 0")))
(assert true)
(define-const var2534 String (toString/-2075883882 var3555)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1215 var2534)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var1215!1 var1519)
(declare-const var2534!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var1519-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2061=org.apache.dubbo.common.utils.AtomicPositiveInteger, var657=r0, var3379=i0, var1519=java.lang.IllegalArgumentException, var1215=$r2, var3683=$r3, var647=$r4, var2312=$r5, var3555=$r6, var2534=$r7}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var2061, r0=var657, i0=var3379, java.lang.IllegalArgumentException=var1519, $r2=var1215, $r3=var3683, $r4=var647, $r5=var2312, $r6=var3555, $r7=var2534}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("delta ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" < 0");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 2