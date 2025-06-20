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

(declare-sort var1911 0)
(declare-sort var510 0)
(declare-sort var2367 0)
(declare-sort var2874 0)
(declare-sort var2710 0)
(declare-sort var3860 0)
(declare-sort var2105 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var510_getAttachment/-2134772037 (var510 String) String)
(declare-fun String_valueOf/-333372740 (var2874) String)
(declare-fun cast-from-String-to-var2874 (String) var2874)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var2710_isAnyEmpty/296893969 ((Array Int String)) Bool)
(declare-fun var2105-init () var2105)
(declare-fun <init>/362238871 (var2105 String) void)
(declare-const null-var1911 var1911)
(declare-const null-var510 var510)
(declare-const null-var2367 var2367)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var3860 var3860)
(declare-const var3940 var1911) ; Statement: r10 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator 
(assert (not (= var3940 null-var1911)))
(declare-const var2500 var510) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2500 null-var510)))
(declare-const var879 var2367) ; Statement: r11 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var879 null-var2367)))
(define-const var455 String (var510_getAttachment/-2134772037 var2500 "ak")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("ak") 
(define-const var3452 String (String_valueOf/-333372740 (cast-from-String-to-var2874 var455))) ; Statement: r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
(define-const var440 String (var510_getAttachment/-2134772037 var2500 "timestamp")) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("timestamp") 
(define-const var363 String (String_valueOf/-333372740 (cast-from-String-to-var2874 var440))) ; Statement: r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3) 
(define-const var1402 String (var510_getAttachment/-2134772037 var2500 "signature")) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("signature") 
(define-const var3797 String (String_valueOf/-333372740 (cast-from-String-to-var2874 var1402))) ; Statement: r6 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5) 
(define-const var101 String (var510_getAttachment/-2134772037 var2500 "consumer")) ; Statement: $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("consumer") 
(define-const var740 String (String_valueOf/-333372740 (cast-from-String-to-var2874 var101))) ; Statement: r8 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r7) 
(define-const var2081 (Array Int String) arr-String-init) ; Statement: $r9 = newarray (java.lang.String)[4] 
(declare-const var2081!1 (Array Int String))
(assert (not (= var2081!1 null-__Array__Int__String__)))
(assert (= (select var2081!1 0) var3452)) ; Statement: $r9[0] = r2 
(declare-const var2081!2 (Array Int String))
(assert (not (= var2081!2 null-__Array__Int__String__)))
(assert (= (select var2081!2 1) var740)) ; Statement: $r9[1] = r8 
(declare-const var2081!3 (Array Int String))
(assert (not (= var2081!3 null-__Array__Int__String__)))
(assert (= (select var2081!3 2) var363)) ; Statement: $r9[2] = r4 
(declare-const var2081!4 (Array Int String))
(assert (not (= var2081!4 null-__Array__Int__String__)))
(assert (= (select var2081!4 3) var3797)) ; Statement: $r9[3] = r6 
(define-const var1903 Bool (var2710_isAnyEmpty/296893969 var2081!4)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r9) 
 ; Statement: if $z0 == 0 goto r12 = virtualinvoke r10.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r0, r11) 
(assert (not (= (ite var1903 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var2088 var3860) ; Statement: $r16 := @caughtexception 
(assert (not (= var2088 null-var3860)))
(define-const var1088 var2105 var2105-init) ; Statement: $r17 = new org.apache.dubbo.auth.exception.RpcAuthenticationException 
(assert true)
;(assert (<init>/362238871 var1088 "Failed to authenticate , can\u0027t load the accessKeyPair")) ; Statement: specialinvoke $r17.<org.apache.dubbo.auth.exception.RpcAuthenticationException: void <init>(java.lang.String)>("Failed to authenticate , can\'t load the accessKeyPair") 

(declare-const var1088!1 var2105)
(declare-const var933 String)
 ; Statement: throw $r17 
(check-sat)
; {var510_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var2874=([java.lang.String], java.lang.Object), arr-String-init=([], java.lang.String[]), var2710_isAnyEmpty/296893969=([java.lang.String[]], boolean), var2105-init=([], org.apache.dubbo.auth.exception.RpcAuthenticationException), <init>/362238871=([org.apache.dubbo.auth.exception.RpcAuthenticationException, java.lang.String], void)}
; {var1911=org.apache.dubbo.auth.AccessKeyAuthenticator, var3940=r10, var510=org.apache.dubbo.rpc.Invocation, var2500=r0, var2367=org.apache.dubbo.common.URL, var879=r11, var455=$r1, var2874=java.lang.Object, var3452=r2, var440=$r3, var363=r4, var1402=$r5, var3797=r6, var101=$r7, var740=r8, var2081=$r9, var2710=org.apache.dubbo.common.utils.StringUtils, var1903=$z0, var3860=java.lang.Exception, var2088=$r16, var2105=org.apache.dubbo.auth.exception.RpcAuthenticationException, var1088=$r17, var933="Failed to authenticate , can\'t load the accessKeyPair"}
; {org.apache.dubbo.auth.AccessKeyAuthenticator=var1911, r10=var3940, org.apache.dubbo.rpc.Invocation=var510, r0=var2500, org.apache.dubbo.common.URL=var2367, r11=var879, $r1=var455, java.lang.Object=var2874, r2=var3452, $r3=var440, r4=var363, $r5=var1402, r6=var3797, $r7=var101, r8=var740, $r9=var2081, org.apache.dubbo.common.utils.StringUtils=var2710, $z0=var1903, java.lang.Exception=var3860, $r16=var2088, org.apache.dubbo.auth.exception.RpcAuthenticationException=var2105, $r17=var1088, "Failed to authenticate , can\'t load the accessKeyPair"=var933}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>": 1}
;stmts r10 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r11 := @parameter1: org.apache.dubbo.common.URL;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("ak");	r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("timestamp");	r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3);	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("signature");	r6 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5);	$r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("consumer");	r8 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r7);	$r9 = newarray (java.lang.String)[4];	$r9[0] = r2;	$r9[1] = r8;	$r9[2] = r4;	$r9[3] = r6;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r9);	if $z0 == 0 goto r12 = virtualinvoke r10.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r0, r11);	$r16 := @caughtexception;	$r17 = new org.apache.dubbo.auth.exception.RpcAuthenticationException;	specialinvoke $r17.<org.apache.dubbo.auth.exception.RpcAuthenticationException: void <init>(java.lang.String)>("Failed to authenticate , can\'t load the accessKeyPair");	throw $r17
;block_num 2