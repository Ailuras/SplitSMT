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

(declare-sort var3253 0)
(declare-sort var2303 0)
(declare-sort var3349 0)
(declare-sort var3978 0)
(declare-sort var157 0)
(declare-sort var382 0)
(declare-sort var1177 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getId/709816357 (var2303) String)
(declare-fun var3349_notEmptyString/1687515918 (String String) void)
(declare-fun initialized/-997129520 (var3253) Bool)
(declare-fun getReferenceKeyByBeanName/859851751 (var3253 String) String)
(declare-fun var3978_isEmpty/-813097145 (String) Bool)
(declare-fun referenceBeanMap/-997129520 (var3253) var157)
(declare-fun var1177_get/1088891777 (var1177 var382) var382)
(declare-fun cast-from-var157-to-var1177 (var157) var1177)
(declare-fun cast-from-String-to-var382 (String) var382)
(declare-fun cast-from-var382-to-var2303 (var382) var2303)
(declare-fun var1177_put/1464166817 (var1177 var382 var382) var382)
(declare-fun cast-from-var2303-to-var382 (var2303) var382)
(declare-fun registerReferenceKeyAndBeanName/505081218 (var3253 String String) void)
(declare-const null-var3253 var3253)
(declare-const null-var2303 var2303)
(declare-const var527 var3253) ; Statement: r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager 
(assert (not (= var527 null-var3253)))
(declare-const var1404 var2303) ; Statement: r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var1404 null-var2303)))
(assert true)
(define-const var3013 String (getId/709816357 var1404)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>() 
;(assert (var3349_notEmptyString/1687515918 var3013 "The id of ReferenceBean cannot be empty")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty") 

(declare-const var3013!1 String)
(declare-const var3054 String)
(define-const var3407 Bool (initialized/-997129520 var527)) ; Statement: $z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized> 
 ; Statement: if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(assert (not (= (ite var3407 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var1399 String (getReferenceKeyByBeanName/859851751 var527 var3013!1)) ; Statement: $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(define-const var2191 String var1399) ; Statement: r29 = $r28 
(define-const var2764 Bool (var3978_isEmpty/-813097145 var1399)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28) 
 ; Statement: if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (= (ite var2764 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3501 var157 (referenceBeanMap/-997129520 var527)) ; Statement: $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(define-const var1793 var382 (var1177_get/1088891777 (cast-from-var157-to-var1177 var3501) (cast-from-String-to-var382 var3013!1))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1160 var2303 (cast-from-var382-to-var2303 var1793)) ; Statement: $r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4 
 ; Statement: if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (= var1160 null-var2303)) ; Cond: $r18 == null 
(define-const var456 var157 (referenceBeanMap/-997129520 var527)) ; Statement: $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
;(assert (var1177_put/1464166817 (cast-from-var157-to-var1177 var456) (cast-from-String-to-var382 var3013!1) (cast-from-var2303-to-var382 var1404))) ; Statement: interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r0) 

(declare-const var456!1 var157)
(declare-const var3013!2 String)
(declare-const var1404!1 var2303)
(assert true)
;(assert (registerReferenceKeyAndBeanName/505081218 var527 var2191 var3013!2)) ; Statement: virtualinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: void registerReferenceKeyAndBeanName(java.lang.String,java.lang.String)>(r29, r1) 

(declare-const var527!1 var3253)
(declare-const var2191!1 String)
(declare-const var3013!3 String)
(define-const var566 Bool (initialized/-997129520 var527!1)) ; Statement: $z2 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized> 
 ; Statement: if $z2 == 0 goto return 
(assert (= (ite var566 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return 
(check-sat)
; {getId/709816357=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.String), var3349_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), initialized/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], boolean), getReferenceKeyByBeanName/859851751=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager, java.lang.String], java.lang.String), var3978_isEmpty/-813097145=([java.lang.String], boolean), referenceBeanMap/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], java.util.concurrent.ConcurrentMap), var1177_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var157-to-var1177=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var382=([java.lang.String], java.lang.Object), cast-from-var382-to-var2303=([java.lang.Object], org.apache.dubbo.config.spring.ReferenceBean), var1177_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var2303-to-var382=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.Object), registerReferenceKeyAndBeanName/505081218=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager, java.lang.String, java.lang.String], void)}
; {var3253=org.apache.dubbo.config.spring.reference.ReferenceBeanManager, var527=r2, var2303=org.apache.dubbo.config.spring.ReferenceBean, var1404=r0, var3013=r1, var3349=org.apache.dubbo.common.utils.Assert, var3054="The id of ReferenceBean cannot be empty", var3407=$z0, var1399=$r28, var2191=r29, var3978=org.apache.dubbo.common.utils.StringUtils, var2764=$z1, var157=java.util.concurrent.ConcurrentMap, var3501=$r3, var382=java.lang.Object, var1177=java.util.Map, var1793=$r4, var1160=$r18, var456=$r5, var566=$z2}
; {org.apache.dubbo.config.spring.reference.ReferenceBeanManager=var3253, r2=var527, org.apache.dubbo.config.spring.ReferenceBean=var2303, r0=var1404, r1=var3013, org.apache.dubbo.common.utils.Assert=var3349, "The id of ReferenceBean cannot be empty"=var3054, $z0=var3407, $r28=var1399, r29=var2191, org.apache.dubbo.common.utils.StringUtils=var3978, $z1=var2764, java.util.concurrent.ConcurrentMap=var157, $r3=var3501, java.lang.Object=var382, java.util.Map=var1177, $r4=var1793, $r18=var1160, $r5=var456, $z2=var566}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager;	r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty");	$z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized>;	if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	$r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	r29 = $r28;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28);	if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1);	$r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4;	if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r0);	virtualinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: void registerReferenceKeyAndBeanName(java.lang.String,java.lang.String)>(r29, r1);	$z2 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized>;	if $z2 == 0 goto return;	return
;block_num 5