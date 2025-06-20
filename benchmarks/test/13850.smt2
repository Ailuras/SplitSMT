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

(declare-sort var2891 0)
(declare-sort var760 0)
(declare-sort var1993 0)
(declare-sort var129 0)
(declare-sort var1848 0)
(declare-sort var2091 0)
(declare-sort var2932 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun frameworkModel/-1004623346 (var2891) var1993)
(declare-fun defaultApplication/-72063182 (var1993) var129)
(declare-fun var2091_getGlobalConfiguration/-670113096 (var2932) var1848)
(declare-fun cast-from-var129-to-var2932 (var129) var2932)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun filterName/-1004623346 (var2891) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1848_getString/-1338273427 (var1848 String) String)
(declare-const null-var2891 var2891)
(declare-const null-String String)
(declare-const var2063 var2891) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig 
(assert (not (= var2063 null-var2891)))
(declare-const var2042 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var2042 null-String)))
(define-const var3165 var1993 (frameworkModel/-1004623346 var2063)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var3021 var129 (defaultApplication/-72063182 var3165)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var602 var1848 (var2091_getGlobalConfiguration/-670113096 (cast-from-var129-to-var2932 var3021))) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2) 
(define-const var1719 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1719)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1719!1 String)
(assert (= var1719!1 ""))
(assert true)
(define-const var3328 String (append/672562846 var1719!1 "dubbo.protocol.triple.rest.filter-config.")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.filter-config.") 
(declare-const var1719!2 String)
(assert (= var1719!2 (str.++ var1719!1 "dubbo.protocol.triple.rest.filter-config.")))
(define-const var2352 String (filterName/-1004623346 var2063)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig: java.lang.String filterName> 
(assert true)
(define-const var2049 String (append/672562846 var3328 var2352)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3328!1 String)
(assert (= var3328!1 (str.++ var3328 var2352)))
(assert true)
(define-const var2733 String (append/672562846 var2049 ".")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2049!1 String)
(assert (= var2049!1 (str.++ var2049 ".")))
(assert true)
(define-const var931 String (append/672562846 var2733 var2042)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var2733!1 String)
(assert (= var2733!1 (str.++ var2733 var2042)))
(assert true)
(define-const var713 String (toString/-2075883882 var931)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var149 String (var1848_getString/-1338273427 var602 var713)) ; Statement: r16 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11) 
 ; Statement: if r16 != null goto return r16 
(assert (not (= var149 null-String))) ; Cond: r16 != null 
 ; Statement: return r16 
(check-sat)
; {frameworkModel/-1004623346=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig], org.apache.dubbo.rpc.model.FrameworkModel), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var2091_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var129-to-var2932=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), filterName/-1004623346=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1848_getString/-1338273427=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.String)}
; {var2891=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig, var2063=r0, var2042=r8, var760=null_type, var1993=org.apache.dubbo.rpc.model.FrameworkModel, var3165=$r1, var129=org.apache.dubbo.rpc.model.ApplicationModel, var3021=$r2, var1848=org.apache.dubbo.common.config.Configuration, var2091=org.apache.dubbo.common.config.ConfigurationUtils, var2932=org.apache.dubbo.rpc.model.ScopeModel, var602=r3, var1719=$r4, var3328=$r6, var2352=$r5, var2049=$r7, var2733=$r9, var931=$r10, var713=$r11, var149=r16}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig=var2891, r0=var2063, r8=var2042, null_type=var760, org.apache.dubbo.rpc.model.FrameworkModel=var1993, $r1=var3165, org.apache.dubbo.rpc.model.ApplicationModel=var129, $r2=var3021, org.apache.dubbo.common.config.Configuration=var1848, org.apache.dubbo.common.config.ConfigurationUtils=var2091, org.apache.dubbo.rpc.model.ScopeModel=var2932, r3=var602, $r4=var1719, $r6=var3328, $r5=var2352, $r7=var2049, $r9=var2733, $r10=var931, $r11=var713, r16=var149}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig;	r8 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2);	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.protocol.triple.rest.filter-config.");	$r5 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.DummyFilterConfig: java.lang.String filterName>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r16 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>($r11);	if r16 != null goto return r16;	return r16
;block_num 2