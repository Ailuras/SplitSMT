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

(declare-sort var1360 0)
(declare-sort var1306 0)
(declare-sort var615 0)
(declare-sort var3798 0)
(declare-sort var3774 0)
(declare-sort var1189 0)
(declare-sort var744 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun frameworkModel/-1434564982 (var1360) var615)
(declare-fun defaultApplication/-72063182 (var615) var3798)
(declare-fun var1189_getGlobalConfiguration/-670113096 (var744) var3774)
(declare-fun cast-from-var3798-to-var744 (var3798) var744)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun filterName/-1434564982 (var1360) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3774_getString/-1338273427 (var3774 String) String)
(declare-const null-var1360 var1360)
(declare-const null-String String)
(declare-const var668 var1360) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig 
(assert (not (= var668 null-var1360)))
(declare-const var1657 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var1657 null-String)))
(define-const var176 var615 (frameworkModel/-1434564982 var668)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var917 var3798 (defaultApplication/-72063182 var176)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var9 var3774 (var1189_getGlobalConfiguration/-670113096 (cast-from-var3798-to-var744 var917))) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2) 
(define-const var2948 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2948)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2948!1 String)
(assert (= var2948!1 ""))
(assert true)
(define-const var3267 String (append/672562846 var2948!1 "dubbo.protocol.triple.rest.filter-config.")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.filter-config.") 
(declare-const var2948!2 String)
(assert (= var2948!2 (str.++ var2948!1 "dubbo.protocol.triple.rest.filter-config.")))
(define-const var2558 String (filterName/-1434564982 var668)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig: java.lang.String filterName> 
(assert true)
(define-const var3286 String (append/672562846 var3267 var2558)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3267!1 String)
(assert (= var3267!1 (str.++ var3267 var2558)))
(assert true)
(define-const var111 String (append/672562846 var3286 ".")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3286!1 String)
(assert (= var3286!1 (str.++ var3286 ".")))
(assert true)
(define-const var1637 String (append/672562846 var111 var1657)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var111!1 String)
(assert (= var111!1 (str.++ var111 var1657)))
(assert true)
(define-const var1307 String (toString/-2075883882 var1637)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1997 String (var3774_getString/-1338273427 var9 var1307)) ; Statement: r16 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11) 
 ; Statement: if r16 != null goto return r16 
(assert (not (= var1997 null-String))) ; Cond: r16 != null 
 ; Statement: return r16 
(check-sat)
; {frameworkModel/-1434564982=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig], org.apache.dubbo.rpc.model.FrameworkModel), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var1189_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var3798-to-var744=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), filterName/-1434564982=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3774_getString/-1338273427=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.String)}
; {var1360=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig, var668=r0, var1657=r8, var1306=null_type, var615=org.apache.dubbo.rpc.model.FrameworkModel, var176=$r1, var3798=org.apache.dubbo.rpc.model.ApplicationModel, var917=$r2, var3774=org.apache.dubbo.common.config.Configuration, var1189=org.apache.dubbo.common.config.ConfigurationUtils, var744=org.apache.dubbo.rpc.model.ScopeModel, var9=r3, var2948=$r4, var3267=$r6, var2558=$r5, var3286=$r7, var111=$r9, var1637=$r10, var1307=$r11, var1997=r16}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig=var1360, r0=var668, r8=var1657, null_type=var1306, org.apache.dubbo.rpc.model.FrameworkModel=var615, $r1=var176, org.apache.dubbo.rpc.model.ApplicationModel=var3798, $r2=var917, org.apache.dubbo.common.config.Configuration=var3774, org.apache.dubbo.common.config.ConfigurationUtils=var1189, org.apache.dubbo.rpc.model.ScopeModel=var744, r3=var9, $r4=var2948, $r6=var3267, $r5=var2558, $r7=var3286, $r9=var111, $r10=var1637, $r11=var1307, r16=var1997}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig;	r8 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2);	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.filter-config.");	$r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.DummyFilterConfig: java.lang.String filterName>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r16 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11);	if r16 != null goto return r16;	return r16
;block_num 2