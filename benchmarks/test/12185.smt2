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

(declare-sort var3755 0)
(declare-sort var2197 0)
(declare-sort var1363 0)
(declare-sort var2507 0)
(declare-sort var2478 0)
(declare-sort var1332 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2197_getAttachment/-2134772037 (var2197 String) String)
(declare-fun String_valueOf/-333372740 (var2507) String)
(declare-fun cast-from-String-to-var2507 (String) var2507)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var2478_isAnyEmpty/296893969 ((Array Int String)) Bool)
(declare-fun var1332-init () var1332)
(declare-fun <init>/362238871 (var1332 String) void)
(declare-const null-var3755 var3755)
(declare-const null-var2197 var2197)
(declare-const null-var1363 var1363)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1461 var3755) ; Statement: r10 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator 
(assert (not (= var1461 null-var3755)))
(declare-const var3886 var2197) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3886 null-var2197)))
(declare-const var3249 var1363) ; Statement: r11 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3249 null-var1363)))
(define-const var908 String (var2197_getAttachment/-2134772037 var3886 "ak")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("ak") 
(define-const var3312 String (String_valueOf/-333372740 (cast-from-String-to-var2507 var908))) ; Statement: r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
(define-const var3692 String (var2197_getAttachment/-2134772037 var3886 "timestamp")) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("timestamp") 
(define-const var953 String (String_valueOf/-333372740 (cast-from-String-to-var2507 var3692))) ; Statement: r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3) 
(define-const var1635 String (var2197_getAttachment/-2134772037 var3886 "signature")) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("signature") 
(define-const var3506 String (String_valueOf/-333372740 (cast-from-String-to-var2507 var1635))) ; Statement: r6 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5) 
(define-const var2580 String (var2197_getAttachment/-2134772037 var3886 "consumer")) ; Statement: $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("consumer") 
(define-const var1510 String (String_valueOf/-333372740 (cast-from-String-to-var2507 var2580))) ; Statement: r8 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r7) 
(define-const var3006 (Array Int String) arr-String-init) ; Statement: $r9 = newarray (java.lang.String)[4] 
(declare-const var3006!1 (Array Int String))
(assert (not (= var3006!1 null-__Array__Int__String__)))
(assert (= (select var3006!1 0) var3312)) ; Statement: $r9[0] = r2 
(declare-const var3006!2 (Array Int String))
(assert (not (= var3006!2 null-__Array__Int__String__)))
(assert (= (select var3006!2 1) var1510)) ; Statement: $r9[1] = r8 
(declare-const var3006!3 (Array Int String))
(assert (not (= var3006!3 null-__Array__Int__String__)))
(assert (= (select var3006!3 2) var953)) ; Statement: $r9[2] = r4 
(declare-const var3006!4 (Array Int String))
(assert (not (= var3006!4 null-__Array__Int__String__)))
(assert (= (select var3006!4 3) var3506)) ; Statement: $r9[3] = r6 
(define-const var2359 Bool (var2478_isAnyEmpty/296893969 var3006!4)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r9) 
 ; Statement: if $z0 == 0 goto r12 = virtualinvoke r10.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r0, r11) 
(assert (not (= (ite var2359 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2996 var1332 var1332-init) ; Statement: $r15 = new org.apache.dubbo.auth.exception.RpcAuthenticationException 
(assert true)
;(assert (<init>/362238871 var2996 "Failed to authenticate, maybe consumer side did not enable the auth")) ; Statement: specialinvoke $r15.<org.apache.dubbo.auth.exception.RpcAuthenticationException: void <init>(java.lang.String)>("Failed to authenticate, maybe consumer side did not enable the auth") 

(declare-const var2996!1 var1332)
(declare-const var3283 String)
 ; Statement: throw $r15 
(check-sat)
; {var2197_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var2507=([java.lang.String], java.lang.Object), arr-String-init=([], java.lang.String[]), var2478_isAnyEmpty/296893969=([java.lang.String[]], boolean), var1332-init=([], org.apache.dubbo.auth.exception.RpcAuthenticationException), <init>/362238871=([org.apache.dubbo.auth.exception.RpcAuthenticationException, java.lang.String], void)}
; {var3755=org.apache.dubbo.auth.AccessKeyAuthenticator, var1461=r10, var2197=org.apache.dubbo.rpc.Invocation, var3886=r0, var1363=org.apache.dubbo.common.URL, var3249=r11, var908=$r1, var2507=java.lang.Object, var3312=r2, var3692=$r3, var953=r4, var1635=$r5, var3506=r6, var2580=$r7, var1510=r8, var3006=$r9, var2478=org.apache.dubbo.common.utils.StringUtils, var2359=$z0, var1332=org.apache.dubbo.auth.exception.RpcAuthenticationException, var2996=$r15, var3283="Failed to authenticate, maybe consumer side did not enable the auth"}
; {org.apache.dubbo.auth.AccessKeyAuthenticator=var3755, r10=var1461, org.apache.dubbo.rpc.Invocation=var2197, r0=var3886, org.apache.dubbo.common.URL=var1363, r11=var3249, $r1=var908, java.lang.Object=var2507, r2=var3312, $r3=var3692, r4=var953, $r5=var1635, r6=var3506, $r7=var2580, r8=var1510, $r9=var3006, org.apache.dubbo.common.utils.StringUtils=var2478, $z0=var2359, org.apache.dubbo.auth.exception.RpcAuthenticationException=var1332, $r15=var2996, "Failed to authenticate, maybe consumer side did not enable the auth"=var3283}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>": 1}
;stmts r10 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r11 := @parameter1: org.apache.dubbo.common.URL;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("ak");	r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("timestamp");	r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3);	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("signature");	r6 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5);	$r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("consumer");	r8 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r7);	$r9 = newarray (java.lang.String)[4];	$r9[0] = r2;	$r9[1] = r8;	$r9[2] = r4;	$r9[3] = r6;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r9);	if $z0 == 0 goto r12 = virtualinvoke r10.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r0, r11);	$r15 = new org.apache.dubbo.auth.exception.RpcAuthenticationException;	specialinvoke $r15.<org.apache.dubbo.auth.exception.RpcAuthenticationException: void <init>(java.lang.String)>("Failed to authenticate, maybe consumer side did not enable the auth");	throw $r15
;block_num 2