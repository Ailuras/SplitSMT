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

(declare-sort var2485 0)
(declare-sort var892 0)
(declare-sort var3312 0)
(declare-sort var3579 0)
(declare-sort var3406 0)
(declare-sort var1321 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun get/1554949104 (var3312) var3579)
(declare-fun cast-from-var3579-to-var3406 (var3579) var3406)
(declare-fun getAttachment/570155806 (var3406 String) String)
(declare-fun var1321_isEmpty/-813097145 (String) Bool)
(declare-const null-var2485 var2485)
(declare-const null-String String)
(declare-const var2485-CLIENT_ATTACHMENT var3312)
(declare-const var2485-SERVER_ATTACHMENT var3312)
(declare-const var1229 var2485) ; Statement: r9 := @this: org.apache.dubbo.rpc.RpcContext 
(assert (not (= var1229 null-var2485)))
(declare-const var902 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var902 null-String)))
(define-const var3756 var3312 var2485-CLIENT_ATTACHMENT) ; Statement: $r0 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal CLIENT_ATTACHMENT> 
(assert true)
(define-const var93 var3579 (get/1554949104 var3756)) ; Statement: $r1 = virtualinvoke $r0.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>() 
(define-const var2008 var3406 (cast-from-var3579-to-var3406 var93)) ; Statement: $r3 = (org.apache.dubbo.rpc.RpcContextAttachment) $r1 
(assert true)
(define-const var148 String (getAttachment/570155806 var2008 var902)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2) 
(define-const var2395 Bool (var1321_isEmpty/-813097145 var148)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (not (= (ite var2395 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1358 var3312 var2485-SERVER_ATTACHMENT) ; Statement: $r5 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal SERVER_ATTACHMENT> 
(assert true)
(define-const var916 var3579 (get/1554949104 var1358)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>() 
(define-const var3680 var3406 (cast-from-var3579-to-var3406 var916)) ; Statement: $r7 = (org.apache.dubbo.rpc.RpcContextAttachment) $r6 
(assert true)
(define-const var1529 String (getAttachment/570155806 var3680 var902)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2) 
 ; Statement: return $r8 
(check-sat)
; {get/1554949104=([org.apache.dubbo.common.threadlocal.InternalThreadLocal], java.lang.Object), cast-from-var3579-to-var3406=([java.lang.Object], org.apache.dubbo.rpc.RpcContextAttachment), getAttachment/570155806=([org.apache.dubbo.rpc.RpcContextAttachment, java.lang.String], java.lang.String), var1321_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2485=org.apache.dubbo.rpc.RpcContext, var1229=r9, var902=r2, var892=null_type, var3312=org.apache.dubbo.common.threadlocal.InternalThreadLocal, var3756=$r0, var3579=java.lang.Object, var93=$r1, var3406=org.apache.dubbo.rpc.RpcContextAttachment, var2008=$r3, var148=r4, var1321=org.apache.dubbo.common.utils.StringUtils, var2395=$z0, var1358=$r5, var916=$r6, var3680=$r7, var1529=$r8}
; {org.apache.dubbo.rpc.RpcContext=var2485, r9=var1229, r2=var902, null_type=var892, org.apache.dubbo.common.threadlocal.InternalThreadLocal=var3312, $r0=var3756, java.lang.Object=var3579, $r1=var93, org.apache.dubbo.rpc.RpcContextAttachment=var3406, $r3=var2008, r4=var148, org.apache.dubbo.common.utils.StringUtils=var1321, $z0=var2395, $r5=var1358, $r6=var916, $r7=var3680, $r8=var1529}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.RpcContext;	r2 := @parameter0: java.lang.String;	$r0 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal CLIENT_ATTACHMENT>;	$r1 = virtualinvoke $r0.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>();	$r3 = (org.apache.dubbo.rpc.RpcContextAttachment) $r1;	r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	$r5 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal SERVER_ATTACHMENT>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>();	$r7 = (org.apache.dubbo.rpc.RpcContextAttachment) $r6;	$r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2);	return $r8
;block_num 2