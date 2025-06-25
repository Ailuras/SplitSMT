(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var68 0)
(declare-sort var1142 0)
(declare-sort var1216 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var68_getServiceModel/1214805812 (var68) var1142)
(declare-fun var68_getTargetServiceUniqueName/-1786712159 (var68) String)
(declare-const null-var68 var68)
(declare-const null-var1142 var1142)
(declare-const null-String String)
(declare-const var592 var68) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var592 null-var68)))
(define-const var569 var1142 (var68_getServiceModel/1214805812 var592)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
 ; Statement: if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= var569 null-var1142)) ; Cond: $r1 == null 
(define-const var1793 String (var68_getTargetServiceUniqueName/-1786712159 var592)) ; Statement: $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(define-const var1396 String null-String) ; Statement: r9 = null 
; split operation: var3008 = var1793.split("/") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2259 Int (get_split_length var1793 "/" -1)) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 != 2 goto return r9 
(assert (not (= var2259 2))) ; Cond: $i0 != 2 
 ; Statement: return r9 
(check-sat)
; {var68_getServiceModel/1214805812=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.model.ServiceModel), var68_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var68=org.apache.dubbo.rpc.Invocation, var592=r0, var1142=org.apache.dubbo.rpc.model.ServiceModel, var569=$r1, var1793=$r4, var1216=null_type, var1396=r9, var3008=$r5, var2259=$i0}
; {org.apache.dubbo.rpc.Invocation=var68, r0=var592, org.apache.dubbo.rpc.model.ServiceModel=var1142, $r1=var569, $r4=var1793, null_type=var1216, r9=var1396, $r5=var3008, $i0=var2259}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	r9 = null;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof $r5;	if $i0 != 2 goto return r9;	return r9
;block_num 3