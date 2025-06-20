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

(declare-sort var173 0)
(declare-sort var3626 0)
(declare-sort var2949 0)
(declare-sort var2010 0)
(declare-sort var2485 0)
(declare-sort var1324 0)
(declare-sort var2287 0)
(declare-sort var2425 0)
(declare-sort var3483 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initParameters/225160538 (var173) var2949)
(declare-fun var2949_get/1088891777 (var2949 var2010) var2010)
(declare-fun cast-from-String-to-var2010 (String) var2010)
(declare-fun cast-from-var2010-to-String (var2010) String)
(declare-fun frameworkModel/225160538 (var173) var2485)
(declare-fun defaultApplication/-72063182 (var2485) var1324)
(declare-fun var2425_getGlobalConfiguration/-670113096 (var3483) var2287)
(declare-fun cast-from-var1324-to-var3483 (var1324) var3483)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2287_getString/-1338273427 (var2287 String) String)
(declare-const null-var173 var173)
(declare-const null-String String)
(declare-const var2360 var173) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext 
(assert (not (= var2360 null-var173)))
(declare-const var576 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var576 null-String)))
(define-const var1959 var2949 (initParameters/225160538 var2360)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: java.util.Map initParameters> 
(define-const var3113 var2010 (var2949_get/1088891777 var1959 (cast-from-String-to-var2010 var576))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1328 String (cast-from-var2010-to-String var3113)) ; Statement: r4 = (java.lang.String) $r3 
 ; Statement: if r4 == null goto $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert (= var1328 null-String)) ; Cond: r4 == null 
(define-const var3516 var2485 (frameworkModel/225160538 var2360)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var2695 var1324 (defaultApplication/-72063182 var3516)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var2981 var2287 (var2425_getGlobalConfiguration/-670113096 (cast-from-var1324-to-var3483 var2695))) ; Statement: r7 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r6) 
(define-const var1729 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1729)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1729!1 String)
(assert (= var1729!1 ""))
(assert true)
(define-const var609 String (append/672562846 var1729!1 "dubbo.protocol.triple.rest.servlet-context.")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.servlet-context.") 
(declare-const var1729!2 String)
(assert (= var1729!2 (str.++ var1729!1 "dubbo.protocol.triple.rest.servlet-context.")))
(assert true)
(define-const var2190 String (append/672562846 var609 var576)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var609!1 String)
(assert (= var609!1 (str.++ var609 var576)))
(assert true)
(define-const var158 String (toString/-2075883882 var2190)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1745 String (var2287_getString/-1338273427 var2981 var158)) ; Statement: $r12 = interfaceinvoke r7.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11) 
 ; Statement: return $r12 
(check-sat)
; {initParameters/225160538=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext], java.util.Map), var2949_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2010=([java.lang.String], java.lang.Object), cast-from-var2010-to-String=([java.lang.Object], java.lang.String), frameworkModel/225160538=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext], org.apache.dubbo.rpc.model.FrameworkModel), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var2425_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var1324-to-var3483=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2287_getString/-1338273427=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.String)}
; {var173=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext, var2360=r0, var576=r1, var3626=null_type, var2949=java.util.Map, var1959=$r2, var2010=java.lang.Object, var3113=$r3, var1328=r4, var2485=org.apache.dubbo.rpc.model.FrameworkModel, var3516=$r5, var1324=org.apache.dubbo.rpc.model.ApplicationModel, var2695=$r6, var2287=org.apache.dubbo.common.config.Configuration, var2425=org.apache.dubbo.common.config.ConfigurationUtils, var3483=org.apache.dubbo.rpc.model.ScopeModel, var2981=r7, var1729=$r8, var609=$r9, var2190=$r10, var158=$r11, var1745=$r12}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext=var173, r0=var2360, r1=var576, null_type=var3626, java.util.Map=var2949, $r2=var1959, java.lang.Object=var2010, $r3=var3113, r4=var1328, org.apache.dubbo.rpc.model.FrameworkModel=var2485, $r5=var3516, org.apache.dubbo.rpc.model.ApplicationModel=var1324, $r6=var2695, org.apache.dubbo.common.config.Configuration=var2287, org.apache.dubbo.common.config.ConfigurationUtils=var2425, org.apache.dubbo.rpc.model.ScopeModel=var3483, r7=var2981, $r8=var1729, $r9=var609, $r10=var2190, $r11=var158, $r12=var1745}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: java.util.Map initParameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.lang.String) $r3;	if r4 == null goto $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyServletContext: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r7 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r6);	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.servlet-context.");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r12 = interfaceinvoke r7.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11);	return $r12
;block_num 2