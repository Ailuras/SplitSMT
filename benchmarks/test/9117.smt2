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

(declare-sort var1137 0)
(declare-sort var11 0)
(declare-sort var317 0)
(declare-sort var2399 0)
(declare-sort var2130 0)
(declare-sort var3624 0)
(declare-sort var53 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getId/709816357 (var11) String)
(declare-fun var317_notEmptyString/1687515918 (String String) void)
(declare-fun initialized/-997129520 (var1137) Bool)
(declare-fun getReferenceKeyByBeanName/859851751 (var1137 String) String)
(declare-fun var2399_isEmpty/-813097145 (String) Bool)
(declare-fun referenceBeanMap/-997129520 (var1137) var2130)
(declare-fun var53_get/1088891777 (var53 var3624) var3624)
(declare-fun cast-from-var2130-to-var53 (var2130) var53)
(declare-fun cast-from-String-to-var3624 (String) var3624)
(declare-fun cast-from-var3624-to-var11 (var3624) var11)
(declare-const null-var1137 var1137)
(declare-const null-var11 var11)
(declare-const var3422 var1137) ; Statement: r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager 
(assert (not (= var3422 null-var1137)))
(declare-const var888 var11) ; Statement: r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var888 null-var11)))
(assert true)
(define-const var3761 String (getId/709816357 var888)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>() 
;(assert (var317_notEmptyString/1687515918 var3761 "The id of ReferenceBean cannot be empty")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty") 

(declare-const var3761!1 String)
(declare-const var3022 String)
(define-const var2934 Bool (initialized/-997129520 var3422)) ; Statement: $z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized> 
 ; Statement: if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(assert (not (= (ite var2934 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3398 String (getReferenceKeyByBeanName/859851751 var3422 var3761!1)) ; Statement: $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(define-const var3918 String var3398) ; Statement: r29 = $r28 
(define-const var757 Bool (var2399_isEmpty/-813097145 var3398)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28) 
 ; Statement: if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (= (ite var757 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3094 var2130 (referenceBeanMap/-997129520 var3422)) ; Statement: $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(define-const var1401 var3624 (var53_get/1088891777 (cast-from-var2130-to-var53 var3094) (cast-from-String-to-var3624 var3761!1))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var724 var11 (cast-from-var3624-to-var11 var1401)) ; Statement: $r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4 
 ; Statement: if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (not (= var724 null-var11))) ; Negate: Cond: $r18 == null  
 ; Statement: if r0 == $r18 goto return 
(assert (= var888 var724)) ; Cond: r0 == $r18 
 ; Statement: return 
(check-sat)
; {getId/709816357=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.String), var317_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), initialized/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], boolean), getReferenceKeyByBeanName/859851751=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager, java.lang.String], java.lang.String), var2399_isEmpty/-813097145=([java.lang.String], boolean), referenceBeanMap/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], java.util.concurrent.ConcurrentMap), var53_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var2130-to-var53=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var3624=([java.lang.String], java.lang.Object), cast-from-var3624-to-var11=([java.lang.Object], org.apache.dubbo.config.spring.ReferenceBean)}
; {var1137=org.apache.dubbo.config.spring.reference.ReferenceBeanManager, var3422=r2, var11=org.apache.dubbo.config.spring.ReferenceBean, var888=r0, var3761=r1, var317=org.apache.dubbo.common.utils.Assert, var3022="The id of ReferenceBean cannot be empty", var2934=$z0, var3398=$r28, var3918=r29, var2399=org.apache.dubbo.common.utils.StringUtils, var757=$z1, var2130=java.util.concurrent.ConcurrentMap, var3094=$r3, var3624=java.lang.Object, var53=java.util.Map, var1401=$r4, var724=$r18}
; {org.apache.dubbo.config.spring.reference.ReferenceBeanManager=var1137, r2=var3422, org.apache.dubbo.config.spring.ReferenceBean=var11, r0=var888, r1=var3761, org.apache.dubbo.common.utils.Assert=var317, "The id of ReferenceBean cannot be empty"=var3022, $z0=var2934, $r28=var3398, r29=var3918, org.apache.dubbo.common.utils.StringUtils=var2399, $z1=var757, java.util.concurrent.ConcurrentMap=var2130, $r3=var3094, java.lang.Object=var3624, java.util.Map=var53, $r4=var1401, $r18=var724}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager;	r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty");	$z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized>;	if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	$r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	r29 = $r28;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28);	if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1);	$r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4;	if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	if r0 == $r18 goto return;	return
;block_num 5