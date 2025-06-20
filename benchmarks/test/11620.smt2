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

(declare-sort var3727 0)
(declare-sort var2467 0)
(declare-sort var3725 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3727_getServiceModel/1214805812 (var3727) var2467)
(declare-fun var3727_getTargetServiceUniqueName/-1786712159 (var3727) String)
(declare-const null-var3727 var3727)
(declare-const null-var2467 var2467)
(declare-const null-String String)
(declare-const var2479 var3727) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2479 null-var3727)))
(define-const var3140 var2467 (var3727_getServiceModel/1214805812 var2479)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
 ; Statement: if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= var3140 null-var2467)) ; Cond: $r1 == null 
(define-const var539 String (var3727_getTargetServiceUniqueName/-1786712159 var2479)) ; Statement: $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(define-const var506 String null-String) ; Statement: r9 = null 
; split operation: var1706 = var539.split("/") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1254 Int (get_split_length var539 "/" -1)) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 != 2 goto return r9 
(assert (not (= var1254 2))) ; Cond: $i0 != 2 
 ; Statement: return r9 
(check-sat)
; {var3727_getServiceModel/1214805812=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.model.ServiceModel), var3727_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var3727=org.apache.dubbo.rpc.Invocation, var2479=r0, var2467=org.apache.dubbo.rpc.model.ServiceModel, var3140=$r1, var539=$r4, var3725=null_type, var506=r9, var1706=$r5, var1254=$i0}
; {org.apache.dubbo.rpc.Invocation=var3727, r0=var2479, org.apache.dubbo.rpc.model.ServiceModel=var2467, $r1=var3140, $r4=var539, null_type=var3725, r9=var506, $r5=var1706, $i0=var1254}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	r9 = null;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof $r5;	if $i0 != 2 goto return r9;	return r9
;block_num 3