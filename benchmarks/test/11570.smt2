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

(declare-sort var262 0)
(declare-sort var1545 0)
(declare-sort var1841 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var262_getServiceModel/1214805812 (var262) var1545)
(declare-fun var262_getTargetServiceUniqueName/-1786712159 (var262) String)
(declare-fun var1841_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var262 var262)
(declare-const null-var1545 var1545)
(declare-const var3652 var262) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3652 null-var262)))
(define-const var3846 var1545 (var262_getServiceModel/1214805812 var3652)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
 ; Statement: if $r1 == null goto $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= var3846 null-var1545)) ; Cond: $r1 == null 
(define-const var2244 String (var262_getTargetServiceUniqueName/-1786712159 var3652)) ; Statement: $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(define-const var2971 Bool (var1841_isBlank/-523695098 (cast-from-String-to-String var2244))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r7) 
 ; Statement: if $z0 == 0 goto r2 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(assert (not (= (ite var2971 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "" 
(check-sat)
; {var262_getServiceModel/1214805812=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.model.ServiceModel), var262_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String), var1841_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var262=org.apache.dubbo.rpc.Invocation, var3652=r0, var1545=org.apache.dubbo.rpc.model.ServiceModel, var3846=$r1, var2244=$r7, var1841=org.apache.dubbo.common.utils.StringUtils, var2971=$z0}
; {org.apache.dubbo.rpc.Invocation=var262, r0=var3652, org.apache.dubbo.rpc.model.ServiceModel=var1545, $r1=var3846, $r7=var2244, org.apache.dubbo.common.utils.StringUtils=var1841, $z0=var2971}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	if $r1 == null goto $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r7);	if $z0 == 0 goto r2 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	return ""
;block_num 3