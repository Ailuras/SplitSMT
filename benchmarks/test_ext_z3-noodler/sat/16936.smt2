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

(declare-sort var2903 0)
(declare-sort var222 0)
(declare-sort var3474 0)
(declare-sort var3270 0)
(declare-sort var2608 0)
(declare-sort var2267 0)
(declare-sort var227 0)
(declare-sort var944 0)
(declare-sort var2031 0)
(declare-sort var2026 0)
(declare-sort var3536 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3474) void)
(declare-fun cast-from-var2903-to-var3474 (var2903) var3474)
(declare-fun defaultApplication/-72063182 (var222) var3270)
(declare-fun var2267_getGlobalConfiguration/-670113096 (var227) var2608)
(declare-fun cast-from-var3270-to-var227 (var3270) var227)
(declare-fun var2608_getString/-24482226 (var2608 String String) String)
(declare-fun var2026-init () var2026)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2026 String var3536) void)
(declare-fun cast-from-var2031-to-var3536 (var2031) var3536)
(declare-const null-var2903 var2903)
(declare-const null-var222 var222)
(declare-const null-String String)
(declare-const null-var2031 var2031)
(declare-const var834 var2903) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.HttpJsonUtils 
(assert (not (= var834 null-var2903)))
(declare-const var3925 var222) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel 
(assert (not (= var3925 null-var222)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2903-to-var3474 var834))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var834!1 var2903)
(assert true)
(define-const var886 var3270 (defaultApplication/-72063182 var3925)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var272 var2608 (var2267_getGlobalConfiguration/-670113096 (cast-from-var3270-to-var227 var886))) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2) 
(define-const var3596 String (var2608_getString/-24482226 var272 "dubbo.protocol.triple.rest.json-framework" null-String)) ; Statement: r4 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>("dubbo.protocol.triple.rest.json-framework", null) 
 ; Statement: if r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.lang.Object getExtension(java.lang.Class,java.lang.String)>(class "Lorg/apache/dubbo/common/json/JsonUtil;", r4) 
(assert (not (not (= var3596 null-String)))) ; Negate: Cond: r4 != null  
(declare-const var1353 var2031) ; Statement: $r10 := @caughtexception 
(assert (not (= var1353 null-var2031)))
(define-const var1951 var2026 var2026-init) ; Statement: $r11 = new java.lang.IllegalStateException 
(define-const var706 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var706)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var706!1 String)
(assert (= var706!1 ""))
(assert true)
(define-const var3950 String (append/672562846 var706!1 "Failed to load json framework: ")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load json framework: ") 
(declare-const var706!2 String)
(assert (= var706!2 (str.++ var706!1 "Failed to load json framework: ")))
(assert true)
(define-const var2079 String (append/672562846 var3950 var3596)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3950!1 String)
(assert (= var3950!1 (str.++ var3950 var3596)))
(assert true)
(define-const var2652 String (toString/-2075883882 var2079)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1951 var2652 (cast-from-var2031-to-var3536 var1353))) ; Statement: specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r10) 

(declare-const var1951!1 var2026)
(declare-const var2652!1 String)
(declare-const var1353!1 var2031)
 ; Statement: throw $r11 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2903-to-var3474=([org.apache.dubbo.remoting.http12.HttpJsonUtils], java.lang.Object), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var2267_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var3270-to-var227=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var2608_getString/-24482226=([org.apache.dubbo.common.config.Configuration, java.lang.String, java.lang.String], java.lang.String), var2026-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var2031-to-var3536=([java.lang.Exception], java.lang.Throwable)}
; {var2903=org.apache.dubbo.remoting.http12.HttpJsonUtils, var834=r0, var222=org.apache.dubbo.rpc.model.FrameworkModel, var3925=r1, var3474=java.lang.Object, var3270=org.apache.dubbo.rpc.model.ApplicationModel, var886=$r2, var2608=org.apache.dubbo.common.config.Configuration, var2267=org.apache.dubbo.common.config.ConfigurationUtils, var227=org.apache.dubbo.rpc.model.ScopeModel, var272=r3, var944=null_type, var3596=r4, var2031=java.lang.Exception, var1353=$r10, var2026=java.lang.IllegalStateException, var1951=$r11, var706=$r12, var3950=$r13, var2079=$r14, var2652=$r15, var3536=java.lang.Throwable}
; {org.apache.dubbo.remoting.http12.HttpJsonUtils=var2903, r0=var834, org.apache.dubbo.rpc.model.FrameworkModel=var222, r1=var3925, java.lang.Object=var3474, org.apache.dubbo.rpc.model.ApplicationModel=var3270, $r2=var886, org.apache.dubbo.common.config.Configuration=var2608, org.apache.dubbo.common.config.ConfigurationUtils=var2267, org.apache.dubbo.rpc.model.ScopeModel=var227, r3=var272, null_type=var944, r4=var3596, java.lang.Exception=var2031, $r10=var1353, java.lang.IllegalStateException=var2026, $r11=var1951, $r12=var706, $r13=var3950, $r14=var2079, $r15=var2652, java.lang.Throwable=var3536}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.HttpJsonUtils;	r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r2);	r4 = interfaceinvoke r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>("dubbo.protocol.triple.rest.json-framework", null);	if r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.lang.Object getExtension(java.lang.Class,java.lang.String)>(class "Lorg/apache/dubbo/common/json/JsonUtil;", r4);	$r10 := @caughtexception;	$r11 = new java.lang.IllegalStateException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load json framework: ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r10);	throw $r11
;block_num 2