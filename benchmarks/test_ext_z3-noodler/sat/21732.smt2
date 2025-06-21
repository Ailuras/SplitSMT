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

(declare-sort var3099 0)
(declare-sort var2500 0)
(declare-sort var294 0)
(declare-sort var3352 0)
(declare-sort var3202 0)
(declare-sort var12 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun get/1554949104 (var294) var3352)
(declare-fun cast-from-var3352-to-var3202 (var3352) var3202)
(declare-fun getAttachment/570155806 (var3202 String) String)
(declare-fun var12_isEmpty/-813097145 (String) Bool)
(declare-const null-var3099 var3099)
(declare-const null-String String)
(declare-const var3099-CLIENT_ATTACHMENT var294)
(declare-const var324 var3099) ; Statement: r9 := @this: org.apache.dubbo.rpc.RpcContext 
(assert (not (= var324 null-var3099)))
(declare-const var353 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var353 null-String)))
(define-const var3709 var294 var3099-CLIENT_ATTACHMENT) ; Statement: $r0 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal CLIENT_ATTACHMENT> 
(assert true)
(define-const var3404 var3352 (get/1554949104 var3709)) ; Statement: $r1 = virtualinvoke $r0.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>() 
(define-const var3196 var3202 (cast-from-var3352-to-var3202 var3404)) ; Statement: $r3 = (org.apache.dubbo.rpc.RpcContextAttachment) $r1 
(assert true)
(define-const var96 String (getAttachment/570155806 var3196 var353)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2) 
(define-const var237 Bool (var12_isEmpty/-813097145 var96)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var237 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {get/1554949104=([org.apache.dubbo.common.threadlocal.InternalThreadLocal], java.lang.Object), cast-from-var3352-to-var3202=([java.lang.Object], org.apache.dubbo.rpc.RpcContextAttachment), getAttachment/570155806=([org.apache.dubbo.rpc.RpcContextAttachment, java.lang.String], java.lang.String), var12_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3099=org.apache.dubbo.rpc.RpcContext, var324=r9, var353=r2, var2500=null_type, var294=org.apache.dubbo.common.threadlocal.InternalThreadLocal, var3709=$r0, var3352=java.lang.Object, var3404=$r1, var3202=org.apache.dubbo.rpc.RpcContextAttachment, var3196=$r3, var96=r4, var12=org.apache.dubbo.common.utils.StringUtils, var237=$z0}
; {org.apache.dubbo.rpc.RpcContext=var3099, r9=var324, r2=var353, null_type=var2500, org.apache.dubbo.common.threadlocal.InternalThreadLocal=var294, $r0=var3709, java.lang.Object=var3352, $r1=var3404, org.apache.dubbo.rpc.RpcContextAttachment=var3202, $r3=var3196, r4=var96, org.apache.dubbo.common.utils.StringUtils=var12, $z0=var237}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.RpcContext;	r2 := @parameter0: java.lang.String;	$r0 = <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.threadlocal.InternalThreadLocal CLIENT_ATTACHMENT>;	$r1 = virtualinvoke $r0.<org.apache.dubbo.common.threadlocal.InternalThreadLocal: java.lang.Object get()>();	$r3 = (org.apache.dubbo.rpc.RpcContextAttachment) $r1;	r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>(r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 2