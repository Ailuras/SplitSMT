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

(declare-sort var841 0)
(declare-sort var2428 0)
(declare-sort var419 0)
(declare-sort var1185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var419_getServerAttachment/1146677352 () var2428)
(declare-fun getAttachment/570155806 (var2428 String) String)
(declare-fun var1185_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var841 var841)
(declare-const var901 var841) ; Statement: r2 := @this: org.apache.dubbo.rpc.filter.GenericFilter 
(assert (not (= var901 null-var841)))
(define-const var2646 var2428 var419_getServerAttachment/1146677352) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>() 
(assert true)
(define-const var2865 String (getAttachment/570155806 var2646 "generic")) ; Statement: r3 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>("generic") 
(define-const var3244 Bool (var1185_isBlank/-523695098 (cast-from-String-to-String var2865))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (= (ite var3244 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r3 
(check-sat)
; {var419_getServerAttachment/1146677352=([], org.apache.dubbo.rpc.RpcContextAttachment), getAttachment/570155806=([org.apache.dubbo.rpc.RpcContextAttachment, java.lang.String], java.lang.String), var1185_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var841=org.apache.dubbo.rpc.filter.GenericFilter, var901=r2, var2428=org.apache.dubbo.rpc.RpcContextAttachment, var419=org.apache.dubbo.rpc.RpcContext, var2646=$r0, var2865=r3, var1185=org.apache.dubbo.common.utils.StringUtils, var3244=$z0}
; {org.apache.dubbo.rpc.filter.GenericFilter=var841, r2=var901, org.apache.dubbo.rpc.RpcContextAttachment=var2428, org.apache.dubbo.rpc.RpcContext=var419, $r0=var2646, r3=var2865, org.apache.dubbo.common.utils.StringUtils=var1185, $z0=var3244}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.filter.GenericFilter;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>();	r3 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcContextAttachment: java.lang.String getAttachment(java.lang.String)>("generic");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto return r3;	return r3
;block_num 2