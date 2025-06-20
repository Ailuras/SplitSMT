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

(declare-sort var985 0)
(declare-sort var1217 0)
(declare-sort var1987 0)
(declare-sort var822 0)
(declare-sort var1686 0)
(declare-sort var547 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var985 String) Bool)
(declare-fun var822_getServiceContext/735675290 () var1987)
(declare-fun getConsumerUrl/-1021200294 (var1987) var1686)
(declare-fun getServiceParameter/1782298180 (var1686 String String) String)
(declare-fun var547_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var985 var985)
(declare-const null-String String)
(declare-const null-var1686 var1686)
(declare-const var1231 var985) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1231 null-var985)))
(declare-const var1364 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1364 null-String)))
(declare-const var2222 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2222 null-String)))
(assert true)
(define-const var871 Bool (consumerParamFirst/5744255 var1231 var2222)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (not (= (ite var871 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3832 var1987 var822_getServiceContext/735675290) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var3705 var1686 (getConsumerUrl/-1021200294 var3832)) ; Statement: r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r7 == null goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (not (= var3705 null-var1686))) ; Negate: Cond: r7 == null  
(assert true)
(define-const var2230 String (getServiceParameter/1782298180 var3705 var1364 var2222)) ; Statement: r6 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r3, r1) 
(define-const var2622 Bool (var547_isNotEmpty/-1251449450 var2230)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z2 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (not (= (ite var2622 1 0) 0))) ; Negate: Cond: $z2 == 0  
 ; Statement: return r6 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), var822_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var547_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var985=org.apache.dubbo.registry.client.InstanceAddressURL, var1231=r0, var1364=r3, var1217=null_type, var2222=r1, var871=$z0, var1987=org.apache.dubbo.rpc.RpcServiceContext, var822=org.apache.dubbo.rpc.RpcContext, var3832=$r5, var1686=org.apache.dubbo.common.URL, var3705=r7, var2230=r6, var547=org.apache.dubbo.common.utils.StringUtils, var2622=$z2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var985, r0=var1231, r3=var1364, null_type=var1217, r1=var2222, $z0=var871, org.apache.dubbo.rpc.RpcServiceContext=var1987, org.apache.dubbo.rpc.RpcContext=var822, $r5=var3832, org.apache.dubbo.common.URL=var1686, r7=var3705, r6=var2230, org.apache.dubbo.common.utils.StringUtils=var547, $z2=var2622}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	$r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r7 == null goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	r6 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r3, r1);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z2 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	return r6
;block_num 4