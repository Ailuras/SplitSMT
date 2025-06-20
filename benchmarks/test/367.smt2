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

(declare-sort var3815 0)
(declare-sort var2161 0)
(declare-sort var2716 0)
(declare-sort var2863 0)
(declare-sort var3286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3286_getUrl/-275947851 (var3286) var2863)
(declare-fun cast-from-var2161-to-var3286 (var2161) var3286)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun getAddress/-2093578336 (var2863) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2716_getProtocolServiceKey/-434455497 (var2716) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3815 var3815)
(declare-const null-var2161 var2161)
(declare-const null-var2716 var2716)
(declare-const var3784 var3815) ; Statement: r9 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance 
(assert (not (= var3784 null-var3815)))
(declare-const var3229 var2161) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3229 null-var2161)))
(declare-const var1238 var2716) ; Statement: r5 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1238 null-var2716)))
(define-const var439 var2863 (var3286_getUrl/-275947851 (cast-from-var2161-to-var3286 var3229))) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var3868 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var3868 128)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>(int)>(128) 

(declare-const var3868!1 String)
(declare-const var3169 Int)
(assert true)
(define-const var1153 String (getAddress/-2093578336 var439)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var856 String (append/672562846 var3868!1 var1153)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3868!2 String)
(assert (= var3868!2 (str.++ var3868!1 var1153)))
(assert true)
(define-const var563 String (append/672562846 var856 ":")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var856!1 String)
(assert (= var856!1 (str.++ var856 ":")))
(define-const var1873 String (var2716_getProtocolServiceKey/-434455497 var1238)) ; Statement: $r6 = interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: java.lang.String getProtocolServiceKey()>() 
(assert true)
;(assert (append/672562846 var563 var1873)) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var563!1 String)
(assert (= var563!1 (str.++ var563 var1873)))
(assert true)
(define-const var1173 String (toString/-2075883882 var3868!2)) ; Statement: $r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {var3286_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2161-to-var3286=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2716_getProtocolServiceKey/-434455497=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3815=org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance, var3784=r9, var2161=org.apache.dubbo.rpc.Invoker, var3229=r0, var2716=org.apache.dubbo.rpc.Invocation, var1238=r5, var2863=org.apache.dubbo.common.URL, var3286=org.apache.dubbo.common.Node, var439=r1, var3868=$r2, var3169=128, var1153=$r3, var856=$r4, var563=$r7, var1873=$r6, var1173=$r8}
; {org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance=var3815, r9=var3784, org.apache.dubbo.rpc.Invoker=var2161, r0=var3229, org.apache.dubbo.rpc.Invocation=var2716, r5=var1238, org.apache.dubbo.common.URL=var2863, org.apache.dubbo.common.Node=var3286, r1=var439, $r2=var3868, 128=var3169, $r3=var1153, $r4=var856, $r7=var563, $r6=var1873, $r8=var1173}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r5 := @parameter1: org.apache.dubbo.rpc.Invocation;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>(int)>(128);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: java.lang.String getProtocolServiceKey()>();	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1