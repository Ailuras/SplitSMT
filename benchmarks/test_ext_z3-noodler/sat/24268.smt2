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

(declare-sort var3987 0)
(declare-sort var1270 0)
(declare-sort var1396 0)
(declare-sort var2268 0)
(declare-sort var3013 0)
(declare-sort var181 0)
(declare-sort var2811 0)
(declare-sort var222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mapping/1431496019 (var3987) var3013)
(declare-fun var3013_put/1464166817 (var3013 var181 var181) var181)
(declare-fun cast-from-String-to-var181 (String) var181)
(declare-fun cast-from-var1396-to-var181 (var1396) var181)
(declare-fun cast-from-var181-to-var1396 (var181) var1396)
(declare-fun var2811-init () var2811)
(declare-fun arr-var181-init () (Array Int var181))
(declare-fun var222_getUrl/-275947851 (var222) var2268)
(declare-fun cast-from-var1396-to-var222 (var1396) var222)
(declare-fun cast-from-var2268-to-var181 (var2268) var181)
(declare-fun String_format/1339386452 (String (Array Int var181)) String)
(declare-fun <init>/-1092629202 (var2811 String) void)
(declare-const null-var3987 var3987)
(declare-const null-String String)
(declare-const null-var1396 var1396)
(declare-const null-var2268 var2268)
(declare-const null-__Array__Int__var181__ (Array Int var181))
(declare-const var2834 var3987) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver 
(assert (not (= var2834 null-var3987)))
(declare-const var65 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var65 null-String)))
(declare-const var142 String) ; Statement: r11 := @parameter1: java.lang.String 
(assert (not (= var142 null-String)))
(declare-const var35 var1396) ; Statement: r2 := @parameter2: org.apache.dubbo.rpc.Invoker 
(assert (not (= var35 null-var1396)))
(declare-const var2206 var2268) ; Statement: r6 := @parameter3: org.apache.dubbo.common.URL 
(assert (not (= var2206 null-var2268)))
(define-const var2662 var3013 (mapping/1431496019 var2834)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: java.util.Map mapping> 
(define-const var3399 var181 (var3013_put/1464166817 var2662 (cast-from-String-to-var181 var65) (cast-from-var1396-to-var181 var35))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2) 
(define-const var3813 var1396 (cast-from-var181-to-var1396 var3399)) ; Statement: r29 = (org.apache.dubbo.rpc.Invoker) $r4 
 ; Statement: if r29 == null goto $r7 = <org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (not (= var3813 null-var1396))) ; Negate: Cond: r29 == null  
(assert true)
(define-const var3516 Bool (= var65 var142)) ; Statement: $z2 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>(r11) 
 ; Statement: if $z2 == 0 goto $r22 = new java.lang.IllegalStateException 
(assert (= (ite var3516 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3219 var2811 var2811-init) ; Statement: $r22 = new java.lang.IllegalStateException 
(define-const var844 (Array Int var181) arr-var181-init) ; Statement: $r23 = newarray (java.lang.Object)[3] 
(define-const var2848 var2268 (var222_getUrl/-275947851 (cast-from-var1396-to-var222 var3813))) ; Statement: $r24 = interfaceinvoke r29.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(declare-const var844!1 (Array Int var181))
(assert (not (= var844!1 null-__Array__Int__var181__)))
(assert (= (select var844!1 0) (cast-from-var2268-to-var181 var2848))) ; Statement: $r23[0] = $r24 
(declare-const var844!2 (Array Int var181))
(assert (not (= var844!2 null-__Array__Int__var181__)))
(assert (= (select var844!2 1) (cast-from-String-to-var181 var65))) ; Statement: $r23[1] = r1 
(declare-const var844!3 (Array Int var181))
(assert (not (= var844!3 null-__Array__Int__var181__)))
(assert (= (select var844!3 2) (cast-from-var2268-to-var181 var2206))) ; Statement: $r23[2] = r6 
(define-const var2392 String (String_format/1339386452 "Already exists an invoker[%s] on path[%s], failed to add invoker[%s], please use a unique path." var844!3)) ; Statement: $r25 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Already exists an invoker[%s] on path[%s], failed to add invoker[%s], please use a unique path.", $r23) 
(assert true)
;(assert (<init>/-1092629202 var3219 var2392)) ; Statement: specialinvoke $r22.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25) 

(declare-const var3219!1 var2811)
(declare-const var2392!1 String)
 ; Statement: throw $r22 
(check-sat)
; {mapping/1431496019=([org.apache.dubbo.rpc.protocol.tri.TriplePathResolver], java.util.Map), var3013_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var181=([java.lang.String], java.lang.Object), cast-from-var1396-to-var181=([org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var181-to-var1396=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var2811-init=([], java.lang.IllegalStateException), arr-var181-init=([], java.lang.Object[]), var222_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1396-to-var222=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), cast-from-var2268-to-var181=([org.apache.dubbo.common.URL], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3987=org.apache.dubbo.rpc.protocol.tri.TriplePathResolver, var2834=r0, var65=r1, var1270=null_type, var142=r11, var1396=org.apache.dubbo.rpc.Invoker, var35=r2, var2268=org.apache.dubbo.common.URL, var2206=r6, var3013=java.util.Map, var2662=$r3, var181=java.lang.Object, var3399=$r4, var3813=r29, var3516=$z2, var2811=java.lang.IllegalStateException, var3219=$r22, var844=$r23, var222=org.apache.dubbo.common.Node, var2848=$r24, var2392=$r25}
; {org.apache.dubbo.rpc.protocol.tri.TriplePathResolver=var3987, r0=var2834, r1=var65, null_type=var1270, r11=var142, org.apache.dubbo.rpc.Invoker=var1396, r2=var35, org.apache.dubbo.common.URL=var2268, r6=var2206, java.util.Map=var3013, $r3=var2662, java.lang.Object=var181, $r4=var3399, r29=var3813, $z2=var3516, java.lang.IllegalStateException=var2811, $r22=var3219, $r23=var844, org.apache.dubbo.common.Node=var222, $r24=var2848, $r25=var2392}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver;	r1 := @parameter0: java.lang.String;	r11 := @parameter1: java.lang.String;	r2 := @parameter2: org.apache.dubbo.rpc.Invoker;	r6 := @parameter3: org.apache.dubbo.common.URL;	$r3 = r0.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: java.util.Map mapping>;	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2);	r29 = (org.apache.dubbo.rpc.Invoker) $r4;	if r29 == null goto $r7 = <org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: org.apache.dubbo.common.logger.Logger LOGGER>;	$z2 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>(r11);	if $z2 == 0 goto $r22 = new java.lang.IllegalStateException;	$r22 = new java.lang.IllegalStateException;	$r23 = newarray (java.lang.Object)[3];	$r24 = interfaceinvoke r29.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r23[0] = $r24;	$r23[1] = r1;	$r23[2] = r6;	$r25 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Already exists an invoker[%s] on path[%s], failed to add invoker[%s], please use a unique path.", $r23);	specialinvoke $r22.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25);	throw $r22
;block_num 3