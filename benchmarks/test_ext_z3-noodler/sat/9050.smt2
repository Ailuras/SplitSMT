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

(declare-sort var1486 0)
(declare-sort var1882 0)
(declare-sort var1717 0)
(declare-sort var1977 0)
(declare-sort var1189 0)
(declare-sort var1306 0)
(declare-sort var2689 0)
(declare-sort var64 0)
(declare-sort var3495 0)
(declare-sort var1006 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getId/709816357 (var1882) String)
(declare-fun var1717_notEmptyString/1687515918 (String String) void)
(declare-fun initialized/-997129520 (var1486) Bool)
(declare-fun getReferenceKeyByBeanName/859851751 (var1486 String) String)
(declare-fun var1977_isEmpty/-813097145 (String) Bool)
(declare-fun referenceBeanMap/-997129520 (var1486) var1189)
(declare-fun var2689_get/1088891777 (var2689 var1306) var1306)
(declare-fun cast-from-var1189-to-var2689 (var1189) var2689)
(declare-fun cast-from-String-to-var1306 (String) var1306)
(declare-fun cast-from-var1306-to-var1882 (var1306) var1882)
(declare-fun applicationContext/-997129520 (var1486) var64)
(declare-fun var3495_generateReferenceKey/1383107750 (var1882 var64) String)
(declare-fun var1006-init () var1006)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1006 String) void)
(declare-const null-var1486 var1486)
(declare-const null-var1882 var1882)
(declare-const var130 var1486) ; Statement: r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager 
(assert (not (= var130 null-var1486)))
(declare-const var733 var1882) ; Statement: r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var733 null-var1882)))
(assert true)
(define-const var1086 String (getId/709816357 var733)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>() 
;(assert (var1717_notEmptyString/1687515918 var1086 "The id of ReferenceBean cannot be empty")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty") 

(declare-const var1086!1 String)
(declare-const var2667 String)
(define-const var1309 Bool (initialized/-997129520 var130)) ; Statement: $z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized> 
 ; Statement: if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(assert (not (= (ite var1309 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3133 String (getReferenceKeyByBeanName/859851751 var130 var1086!1)) ; Statement: $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1) 
(define-const var2385 String var3133) ; Statement: r29 = $r28 
(define-const var1677 Bool (var1977_isEmpty/-813097145 var3133)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28) 
 ; Statement: if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (= (ite var1677 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3548 var1189 (referenceBeanMap/-997129520 var130)) ; Statement: $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(define-const var1304 var1306 (var2689_get/1088891777 (cast-from-var1189-to-var2689 var3548) (cast-from-String-to-var1306 var1086!1))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1132 var1882 (cast-from-var1306-to-var1882 var1304)) ; Statement: $r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4 
 ; Statement: if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap> 
(assert (not (= var1132 null-var1882))) ; Negate: Cond: $r18 == null  
 ; Statement: if r0 == $r18 goto return 
(assert (not (= var733 var1132))) ; Negate: Cond: r0 == $r18  
(define-const var1693 var64 (applicationContext/-997129520 var130)) ; Statement: $r6 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: org.springframework.context.ApplicationContext applicationContext> 
(define-const var3091 String (var3495_generateReferenceKey/1383107750 var1132 var1693)) ; Statement: r7 = staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: java.lang.String generateReferenceKey(org.apache.dubbo.config.spring.ReferenceBean,org.springframework.context.ApplicationContext)>($r18, $r6) 
(define-const var2905 var1006 var1006-init) ; Statement: $r8 = new java.lang.IllegalStateException 
(define-const var3989 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3989)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3989!1 String)
(assert (= var3989!1 ""))
(assert true)
(define-const var3245 String (append/672562846 var3989!1 "Found duplicated ReferenceBean with id: ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Found duplicated ReferenceBean with id: ") 
(declare-const var3989!2 String)
(assert (= var3989!2 (str.++ var3989!1 "Found duplicated ReferenceBean with id: ")))
(assert true)
(define-const var2272 String (append/672562846 var3245 var1086!1)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3245!1 String)
(assert (= var3245!1 (str.++ var3245 var1086!1)))
(assert true)
(define-const var141 String (append/672562846 var2272 ", old: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", old: ") 
(declare-const var2272!1 String)
(assert (= var2272!1 (str.++ var2272 ", old: ")))
(assert true)
(define-const var1827 String (append/672562846 var141 var3091)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var141!1 String)
(assert (= var141!1 (str.++ var141 var3091)))
(assert true)
(define-const var386 String (append/672562846 var1827 ", new: ")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", new: ") 
(declare-const var1827!1 String)
(assert (= var1827!1 (str.++ var1827 ", new: ")))
(assert true)
(define-const var166 String (append/672562846 var386 var2385)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r29) 
(declare-const var386!1 String)
(assert (= var386!1 (str.++ var386 var2385)))
(assert true)
(define-const var1873 String (toString/-2075883882 var166)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2905 var1873)) ; Statement: specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r16) 

(declare-const var2905!1 var1006)
(declare-const var1873!1 String)
 ; Statement: throw $r8 
(check-sat)
; {getId/709816357=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.String), var1717_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), initialized/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], boolean), getReferenceKeyByBeanName/859851751=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager, java.lang.String], java.lang.String), var1977_isEmpty/-813097145=([java.lang.String], boolean), referenceBeanMap/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], java.util.concurrent.ConcurrentMap), var2689_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1189-to-var2689=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1306=([java.lang.String], java.lang.Object), cast-from-var1306-to-var1882=([java.lang.Object], org.apache.dubbo.config.spring.ReferenceBean), applicationContext/-997129520=([org.apache.dubbo.config.spring.reference.ReferenceBeanManager], org.springframework.context.ApplicationContext), var3495_generateReferenceKey/1383107750=([org.apache.dubbo.config.spring.ReferenceBean, org.springframework.context.ApplicationContext], java.lang.String), var1006-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1486=org.apache.dubbo.config.spring.reference.ReferenceBeanManager, var130=r2, var1882=org.apache.dubbo.config.spring.ReferenceBean, var733=r0, var1086=r1, var1717=org.apache.dubbo.common.utils.Assert, var2667="The id of ReferenceBean cannot be empty", var1309=$z0, var3133=$r28, var2385=r29, var1977=org.apache.dubbo.common.utils.StringUtils, var1677=$z1, var1189=java.util.concurrent.ConcurrentMap, var3548=$r3, var1306=java.lang.Object, var2689=java.util.Map, var1304=$r4, var1132=$r18, var64=org.springframework.context.ApplicationContext, var1693=$r6, var3495=org.apache.dubbo.config.spring.reference.ReferenceBeanSupport, var3091=r7, var1006=java.lang.IllegalStateException, var2905=$r8, var3989=$r9, var3245=$r10, var2272=$r11, var141=$r12, var1827=$r13, var386=$r14, var166=$r15, var1873=$r16}
; {org.apache.dubbo.config.spring.reference.ReferenceBeanManager=var1486, r2=var130, org.apache.dubbo.config.spring.ReferenceBean=var1882, r0=var733, r1=var1086, org.apache.dubbo.common.utils.Assert=var1717, "The id of ReferenceBean cannot be empty"=var2667, $z0=var1309, $r28=var3133, r29=var2385, org.apache.dubbo.common.utils.StringUtils=var1977, $z1=var1677, java.util.concurrent.ConcurrentMap=var1189, $r3=var3548, java.lang.Object=var1306, java.util.Map=var2689, $r4=var1304, $r18=var1132, org.springframework.context.ApplicationContext=var64, $r6=var1693, org.apache.dubbo.config.spring.reference.ReferenceBeanSupport=var3495, r7=var3091, java.lang.IllegalStateException=var1006, $r8=var2905, $r9=var3989, $r10=var3245, $r11=var2272, $r12=var141, $r13=var1827, $r14=var386, $r15=var166, $r16=var1873}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.reference.ReferenceBeanManager;	r0 := @parameter0: org.apache.dubbo.config.spring.ReferenceBean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String getId()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r1, "The id of ReferenceBean cannot be empty");	$z0 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: boolean initialized>;	if $z0 != 0 goto $r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	$r28 = specialinvoke r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.lang.String getReferenceKeyByBeanName(java.lang.String)>(r1);	r29 = $r28;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28);	if $z1 == 0 goto $r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r3 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	$r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1);	$r18 = (org.apache.dubbo.config.spring.ReferenceBean) $r4;	if $r18 == null goto $r5 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: java.util.concurrent.ConcurrentMap referenceBeanMap>;	if r0 == $r18 goto return;	$r6 = r2.<org.apache.dubbo.config.spring.reference.ReferenceBeanManager: org.springframework.context.ApplicationContext applicationContext>;	r7 = staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: java.lang.String generateReferenceKey(org.apache.dubbo.config.spring.ReferenceBean,org.springframework.context.ApplicationContext)>($r18, $r6);	$r8 = new java.lang.IllegalStateException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Found duplicated ReferenceBean with id: ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", old: ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", new: ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r29);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r16);	throw $r8
;block_num 5