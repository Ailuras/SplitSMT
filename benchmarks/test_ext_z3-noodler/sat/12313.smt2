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

(declare-sort var2976 0)
(declare-sort var209 0)
(declare-sort var2824 0)
(declare-sort var712 0)
(declare-sort var2203 0)
(declare-sort var1922 0)
(declare-sort var120 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2203-init () (Array Int var2203))
(declare-fun getColonSeparatedKey/1043071031 (var209) String)
(declare-fun cast-from-String-to-var2203 (String) var2203)
(declare-fun var1922_getMethodName/-516674313 (var2824) String)
(declare-fun String_format/1339386452 (String (Array Int var2203)) String)
(declare-fun var120_sign/1868756345 (String String) String)
(declare-const null-var2976 var2976)
(declare-const null-var209 var209)
(declare-const null-var2824 var2824)
(declare-const null-String String)
(declare-const null-__Array__Int__var2203__ (Array Int var2203))
(declare-const var2033 var2976) ; Statement: r9 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator 
(assert (not (= var2033 null-var2976)))
(declare-const var3246 var209) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3246 null-var209)))
(declare-const var3974 var2824) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3974 null-var2824)))
(declare-const var2511 String) ; Statement: r5 := @parameter2: java.lang.String 
(assert (not (= var2511 null-String)))
(declare-const var240 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var240 null-String)))
(define-const var2256 (Array Int var2203) arr-var2203-init) ; Statement: $r0 = newarray (java.lang.Object)[4] 
(assert true)
(define-const var358 String (getColonSeparatedKey/1043071031 var3246)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getColonSeparatedKey()>() 
(declare-const var2256!1 (Array Int var2203))
(assert (not (= var2256!1 null-__Array__Int__var2203__)))
(assert (= (select var2256!1 0) (cast-from-String-to-var2203 var358))) ; Statement: $r0[0] = $r2 
(define-const var3581 String (var1922_getMethodName/-516674313 var3974)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(declare-const var2256!2 (Array Int var2203))
(assert (not (= var2256!2 null-__Array__Int__var2203__)))
(assert (= (select var2256!2 1) (cast-from-String-to-var2203 var3581))) ; Statement: $r0[1] = $r4 
(declare-const var2256!3 (Array Int var2203))
(assert (not (= var2256!3 null-__Array__Int__var2203__)))
(assert (= (select var2256!3 2) (cast-from-String-to-var2203 var2511))) ; Statement: $r0[2] = r5 
(declare-const var2256!4 (Array Int var2203))
(assert (not (= var2256!4 null-__Array__Int__var2203__)))
(assert (= (select var2256!4 3) (cast-from-String-to-var2203 var240))) ; Statement: $r0[3] = r6 
(define-const var3130 String (String_format/1339386452 "%s#%s#%s#%s" var2256!4)) ; Statement: r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s#%s#%s#%s", $r0) 
(define-const var2189 String (var120_sign/1868756345 var3130 var2511)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.auth.utils.SignatureUtils: java.lang.String sign(java.lang.String,java.lang.String)>(r7, r5) 
 ; Statement: return $r8 
(check-sat)
; {arr-var2203-init=([], java.lang.Object[]), getColonSeparatedKey/1043071031=([org.apache.dubbo.common.URL], java.lang.String), cast-from-String-to-var2203=([java.lang.String], java.lang.Object), var1922_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var120_sign/1868756345=([java.lang.String, java.lang.String], java.lang.String)}
; {var2976=org.apache.dubbo.auth.AccessKeyAuthenticator, var2033=r9, var209=org.apache.dubbo.common.URL, var3246=r1, var2824=org.apache.dubbo.rpc.Invocation, var3974=r3, var2511=r5, var712=null_type, var240=r6, var2203=java.lang.Object, var2256=$r0, var358=$r2, var1922=org.apache.dubbo.rpc.support.RpcUtils, var3581=$r4, var3130=r7, var120=org.apache.dubbo.auth.utils.SignatureUtils, var2189=$r8}
; {org.apache.dubbo.auth.AccessKeyAuthenticator=var2976, r9=var2033, org.apache.dubbo.common.URL=var209, r1=var3246, org.apache.dubbo.rpc.Invocation=var2824, r3=var3974, r5=var2511, null_type=var712, r6=var240, java.lang.Object=var2203, $r0=var2256, $r2=var358, org.apache.dubbo.rpc.support.RpcUtils=var1922, $r4=var3581, r7=var3130, org.apache.dubbo.auth.utils.SignatureUtils=var120, $r8=var2189}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r9 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator;	r1 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	r5 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.String;	$r0 = newarray (java.lang.Object)[4];	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getColonSeparatedKey()>();	$r0[0] = $r2;	$r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	$r0[1] = $r4;	$r0[2] = r5;	$r0[3] = r6;	r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s#%s#%s#%s", $r0);	$r8 = staticinvoke <org.apache.dubbo.auth.utils.SignatureUtils: java.lang.String sign(java.lang.String,java.lang.String)>(r7, r5);	return $r8
;block_num 1