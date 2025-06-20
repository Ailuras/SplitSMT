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

(declare-sort var1207 0)
(declare-sort var2852 0)
(declare-sort var3964 0)
(declare-sort var1689 0)
(declare-sort var65 0)
(declare-sort var1694 0)
(declare-sort var888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun moduleModel/737601183 (var1207) var3964)
(declare-fun getConfigManager/-335416425 (var3964) var1689)
(declare-fun getConfig/-202802450 (var1689 ClassObject String) var65)
(declare-fun orElse/-757175127 (var65 var1694) var1694)
(declare-fun cast-from-var1694-to-var888 (var1694) var888)
(declare-const null-var1207 var1207)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-NullType var2852)
(declare-const null-var1694 var1694)
(declare-const null-var888 var888)
(declare-const var2138 var1207) ; Statement: r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator 
(assert (not (= var2138 null-var1207)))
(declare-const var1317 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1317 null-String)))
(declare-const var1567 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var1567 null-ClassObject)))
(define-const var163 var3964 (moduleModel/737601183 var2138)) ; Statement: $r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var3528 var1689 (getConfigManager/-335416425 var163)) ; Statement: $r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>() 
(assert true)
(define-const var158 var65 (getConfig/-202802450 var3528 var1567 var1317)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.config.context.ModuleConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r2, r3) 
(assert true)
(define-const var16 var1694 (orElse/-757175127 var158 null-var1694)) ; Statement: $r6 = virtualinvoke $r5.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var403 var888 (cast-from-var1694-to-var888 var16)) ; Statement: r17 = (org.apache.dubbo.config.AbstractConfig) $r6 
 ; Statement: if r17 != null goto (branch) 
(assert (not (= var403 null-var888))) ; Cond: r17 != null 
 ; Statement: if r17 != null goto return r17 
(assert (not (= var403 null-var888))) ; Cond: r17 != null 
 ; Statement: return r17 
(check-sat)
; {moduleModel/737601183=([org.apache.dubbo.config.spring.reference.ReferenceCreator], org.apache.dubbo.rpc.model.ModuleModel), getConfigManager/-335416425=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.config.context.ModuleConfigManager), getConfig/-202802450=([org.apache.dubbo.config.context.ModuleConfigManager, java.lang.Class, java.lang.String], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var1694-to-var888=([java.lang.Object], org.apache.dubbo.config.AbstractConfig)}
; {var1207=org.apache.dubbo.config.spring.reference.ReferenceCreator, var2138=r0, var1317=r3, var2852=null_type, var1567=r2, var3964=org.apache.dubbo.rpc.model.ModuleModel, var163=$r1, var1689=org.apache.dubbo.config.context.ModuleConfigManager, var3528=$r4, var65=java.util.Optional, var158=$r5, var1694=java.lang.Object, var16=$r6, var888=org.apache.dubbo.config.AbstractConfig, var403=r17}
; {org.apache.dubbo.config.spring.reference.ReferenceCreator=var1207, r0=var2138, r3=var1317, null_type=var2852, r2=var1567, org.apache.dubbo.rpc.model.ModuleModel=var3964, $r1=var163, org.apache.dubbo.config.context.ModuleConfigManager=var1689, $r4=var3528, java.util.Optional=var65, $r5=var158, java.lang.Object=var1694, $r6=var16, org.apache.dubbo.config.AbstractConfig=var888, r17=var403}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator;	r3 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	$r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.config.context.ModuleConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r2, r3);	$r6 = virtualinvoke $r5.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	r17 = (org.apache.dubbo.config.AbstractConfig) $r6;	if r17 != null goto (branch);	if r17 != null goto return r17;	return r17
;block_num 3