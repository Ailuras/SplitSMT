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

(declare-sort var3615 0)
(declare-sort var645 0)
(declare-sort var3520 0)
(declare-sort var986 0)
(declare-sort var110 0)
(declare-sort var2373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3520_iterator/-912451715 (var3520) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var110-init () var110)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2373) String)
(declare-fun cast-from-var3520-to-var2373 (var3520) var2373)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var110 String) void)
(declare-const null-var3615 var3615)
(declare-const null-var645 var645)
(declare-const null-var3520 var3520)
(declare-const null-var986 var986)
(declare-const var876 var3615) ; Statement: r9 := @this: org.apache.dubbo.rpc.cluster.support.AvailableClusterInvoker 
(assert (not (= var876 null-var3615)))
(declare-const var3866 var645) ; Statement: r10 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3866 null-var645)))
(declare-const var113 var3520) ; Statement: r0 := @parameter1: java.util.List 
(assert (not (= var113 null-var3520)))
(declare-const var3936 var986) ; Statement: r12 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance 
(assert (not (= var3936 null-var986)))
(define-const var2799 Iterator (var3520_iterator/-912451715 var113)) ; Statement: r1 = interfaceinvoke r0.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3556 Bool (Iterator_hasNext/-1669924200 var2799)) ; Statement: $z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r2 = new org.apache.dubbo.rpc.RpcException 
(assert (= (ite var3556 1 0) 0)) ; Cond: $z0 == 0 
(define-const var690 var110 var110-init) ; Statement: $r2 = new org.apache.dubbo.rpc.RpcException 
(define-const var2245 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2245)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2245!1 String)
(assert (= var2245!1 ""))
(assert true)
(define-const var3142 String (append/672562846 var2245!1 "No provider available in ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No provider available in ") 
(declare-const var2245!2 String)
(assert (= var2245!2 (str.++ var2245!1 "No provider available in ")))
(assert true)
(define-const var2845 String (append/-1031950772 var3142 (cast-from-var3520-to-var2373 var113))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var3142!1 String)
(assert (str.prefixof var3142 var3142!1))
(assert true)
(define-const var2431 String (toString/-2075883882 var2845)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var690 var2431)) ; Statement: specialinvoke $r2.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r6) 

(declare-const var690!1 var110)
(declare-const var2431!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3520_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var110-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3520-to-var2373=([java.util.List], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var3615=org.apache.dubbo.rpc.cluster.support.AvailableClusterInvoker, var876=r9, var645=org.apache.dubbo.rpc.Invocation, var3866=r10, var3520=java.util.List, var113=r0, var986=org.apache.dubbo.rpc.cluster.LoadBalance, var3936=r12, var2799=r1, var3556=$z0, var110=org.apache.dubbo.rpc.RpcException, var690=$r2, var2245=$r3, var3142=$r4, var2373=java.lang.Object, var2845=$r5, var2431=$r6}
; {org.apache.dubbo.rpc.cluster.support.AvailableClusterInvoker=var3615, r9=var876, org.apache.dubbo.rpc.Invocation=var645, r10=var3866, java.util.List=var3520, r0=var113, org.apache.dubbo.rpc.cluster.LoadBalance=var986, r12=var3936, r1=var2799, $z0=var3556, org.apache.dubbo.rpc.RpcException=var110, $r2=var690, $r3=var2245, $r4=var3142, java.lang.Object=var2373, $r5=var2845, $r6=var2431}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.cluster.support.AvailableClusterInvoker;	r10 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 := @parameter1: java.util.List;	r12 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance;	r1 = interfaceinvoke r0.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r2 = new org.apache.dubbo.rpc.RpcException;	$r2 = new org.apache.dubbo.rpc.RpcException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No provider available in ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 3