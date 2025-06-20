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

(declare-sort var3611 0)
(declare-sort var105 0)
(declare-sort var3843 0)
(declare-sort var3828 0)
(declare-sort var3067 0)
(declare-sort var1404 0)
(declare-sort var2523 0)
(declare-sort var3695 0)
(declare-sort var3706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initParameters/1082212318 (var3611) var3843)
(declare-fun var3843_get/1088891777 (var3843 var3828) var3828)
(declare-fun cast-from-String-to-var3828 (String) var3828)
(declare-fun cast-from-var3828-to-String (var3828) String)
(declare-fun frameworkModel/1082212318 (var3611) var3067)
(declare-fun defaultApplication/-72063182 (var3067) var1404)
(declare-fun var3695_getGlobalConfiguration/-670113096 (var3706) var2523)
(declare-fun cast-from-var1404-to-var3706 (var1404) var3706)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2523_getString/-1338273427 (var2523 String) String)
(declare-const null-var3611 var3611)
(declare-const null-String String)
(declare-const var545 var3611) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext 
(assert (not (= var545 null-var3611)))
(declare-const var2840 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2840 null-String)))
(define-const var447 var3843 (initParameters/1082212318 var545)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: java.util.Map initParameters> 
(define-const var927 var3828 (var3843_get/1088891777 var447 (cast-from-String-to-var3828 var2840))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1984 String (cast-from-var3828-to-String var927)) ; Statement: r4 = (java.lang.String) $r3 
 ; Statement: if r4 == null goto $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert (= var1984 null-String)) ; Cond: r4 == null 
(define-const var664 var3067 (frameworkModel/1082212318 var545)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var3324 var1404 (defaultApplication/-72063182 var664)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var997 var2523 (var3695_getGlobalConfiguration/-670113096 (cast-from-var1404-to-var3706 var3324))) ; Statement: r7 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r6) 
(define-const var763 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var763)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var763!1 String)
(assert (= var763!1 ""))
(assert true)
(define-const var1774 String (append/672562846 var763!1 "dubbo.protocol.triple.rest.servlet-context.")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.servlet-context.") 
(declare-const var763!2 String)
(assert (= var763!2 (str.++ var763!1 "dubbo.protocol.triple.rest.servlet-context.")))
(assert true)
(define-const var3691 String (append/672562846 var1774 var2840)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1774!1 String)
(assert (= var1774!1 (str.++ var1774 var2840)))
(assert true)
(define-const var3532 String (toString/-2075883882 var3691)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3976 String (var2523_getString/-1338273427 var997 var3532)) ; Statement: $r12 = interfaceinvoke r7.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11) 
 ; Statement: return $r12 
(check-sat)
; {initParameters/1082212318=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext], java.util.Map), var3843_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3828=([java.lang.String], java.lang.Object), cast-from-var3828-to-String=([java.lang.Object], java.lang.String), frameworkModel/1082212318=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext], org.apache.dubbo.rpc.model.FrameworkModel), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var3695_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var1404-to-var3706=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2523_getString/-1338273427=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.String)}
; {var3611=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext, var545=r0, var2840=r1, var105=null_type, var3843=java.util.Map, var447=$r2, var3828=java.lang.Object, var927=$r3, var1984=r4, var3067=org.apache.dubbo.rpc.model.FrameworkModel, var664=$r5, var1404=org.apache.dubbo.rpc.model.ApplicationModel, var3324=$r6, var2523=org.apache.dubbo.common.config.Configuration, var3695=org.apache.dubbo.common.config.ConfigurationUtils, var3706=org.apache.dubbo.rpc.model.ScopeModel, var997=r7, var763=$r8, var1774=$r9, var3691=$r10, var3532=$r11, var3976=$r12}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext=var3611, r0=var545, r1=var2840, null_type=var105, java.util.Map=var3843, $r2=var447, java.lang.Object=var3828, $r3=var927, r4=var1984, org.apache.dubbo.rpc.model.FrameworkModel=var3067, $r5=var664, org.apache.dubbo.rpc.model.ApplicationModel=var1404, $r6=var3324, org.apache.dubbo.common.config.Configuration=var2523, org.apache.dubbo.common.config.ConfigurationUtils=var3695, org.apache.dubbo.rpc.model.ScopeModel=var3706, r7=var997, $r8=var763, $r9=var1774, $r10=var3691, $r11=var3532, $r12=var3976}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: java.util.Map initParameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.lang.String) $r3;	if r4 == null goto $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r7 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r6);	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.servlet-context.");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r12 = interfaceinvoke r7.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11);	return $r12
;block_num 2