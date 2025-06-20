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

(declare-sort var106 0)
(declare-sort var906 0)
(declare-sort var1205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1205-init () var1205)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var1205 String) void)
(declare-const null-var106 var106)
(declare-const null-String String)
(declare-const var2073 var106) ; Statement: r12 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter 
(assert (not (= var2073 null-var106)))
(declare-const var3290 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3290 null-String)))
(declare-const var682 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var682 null-String)))
(declare-const var918 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var918 null-String)))
(define-const var3412 var1205 var1205-init) ; Statement: $r0 = new org.apache.dubbo.rpc.RpcException 
(define-const var3067 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3067)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3067!1 String)
(assert (= var3067!1 ""))
(assert true)
(define-const var2408 String (append/672562846 var3067!1 "Generic serialization [")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Generic serialization [") 
(declare-const var3067!2 String)
(assert (= var3067!2 (str.++ var3067!1 "Generic serialization [")))
(assert true)
(define-const var3803 String (append/672562846 var2408 var3290)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2408!1 String)
(assert (= var2408!1 (str.++ var2408 var3290)))
(assert true)
(define-const var3356 String (append/672562846 var3803 "] only support message type ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] only support message type ") 
(declare-const var3803!1 String)
(assert (= var3803!1 (str.++ var3803 "] only support message type ")))
(assert true)
(define-const var3392 String (append/672562846 var3356 var682)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var3356!1 String)
(assert (= var3356!1 (str.++ var3356 var682)))
(assert true)
(define-const var2345 String (append/672562846 var3392 " and your message type is ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" and your message type is ") 
(declare-const var3392!1 String)
(assert (= var3392!1 (str.++ var3392 " and your message type is ")))
(assert true)
(define-const var233 String (append/672562846 var2345 var918)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var2345!1 String)
(assert (= var2345!1 (str.++ var2345 var918)))
(assert true)
(define-const var2876 String (toString/-2075883882 var233)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var3412 var2876)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r11) 

(declare-const var3412!1 var1205)
(declare-const var2876!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var1205-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var106=org.apache.dubbo.rpc.filter.GenericImplFilter, var2073=r12, var3290=r2, var906=null_type, var682=r5, var918=r8, var1205=org.apache.dubbo.rpc.RpcException, var3412=$r0, var3067=$r1, var2408=$r3, var3803=$r4, var3356=$r6, var3392=$r7, var2345=$r9, var233=$r10, var2876=$r11}
; {org.apache.dubbo.rpc.filter.GenericImplFilter=var106, r12=var2073, r2=var3290, null_type=var906, r5=var682, r8=var918, org.apache.dubbo.rpc.RpcException=var1205, $r0=var3412, $r1=var3067, $r3=var2408, $r4=var3803, $r6=var3356, $r7=var3392, $r9=var2345, $r10=var233, $r11=var2876}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter;	r2 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	$r0 = new org.apache.dubbo.rpc.RpcException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Generic serialization [");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] only support message type ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" and your message type is ");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r11);	throw $r0
;block_num 1