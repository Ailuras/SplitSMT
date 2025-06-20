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

(declare-sort var1073 0)
(declare-sort var3983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var3983) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1073 var1073)
(declare-const null-var3983 var3983)
(declare-const var2872 var1073) ; Statement: r11 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker 
(assert (not (= var2872 null-var1073)))
(declare-const var3968 var3983) ; Statement: r5 := @parameter0: java.lang.Throwable 
(assert (not (= var3968 null-var3983)))
(declare-const var1342 var3983) ; Statement: r1 := @parameter1: java.lang.Throwable 
(assert (not (= var1342 null-var3983)))
(define-const var1111 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1111)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1111!1 String)
(assert (= var1111!1 ""))
(assert true)
(define-const var2663 String (append/672562846 var1111!1 "mock error : ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock error : ") 
(declare-const var1111!2 String)
(assert (= var1111!2 (str.++ var1111!1 "mock error : ")))
(assert true)
(define-const var1793 String (getMessage/849299655 var1342)) ; Statement: $r2 = virtualinvoke r1.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var254 String (append/672562846 var2663 var1793)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2663!1 String)
(assert (= var2663!1 (str.++ var2663 var1793)))
(assert true)
(define-const var3329 String (toString/-2075883882 var254)) ; Statement: r12 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: if r5 == null goto return r12 
(assert (= var3968 null-var3983)) ; Cond: r5 == null 
 ; Statement: return r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1073=org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker, var2872=r11, var3983=java.lang.Throwable, var3968=r5, var1342=r1, var1111=$r0, var2663=$r3, var1793=$r2, var254=$r4, var3329=r12}
; {org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker=var1073, r11=var2872, java.lang.Throwable=var3983, r5=var3968, r1=var1342, $r0=var1111, $r3=var2663, $r2=var1793, $r4=var254, r12=var3329}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker;	r5 := @parameter0: java.lang.Throwable;	r1 := @parameter1: java.lang.Throwable;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock error : ");	$r2 = virtualinvoke r1.<java.lang.Throwable: java.lang.String getMessage()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	r12 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	if r5 == null goto return r12;	return r12
;block_num 2