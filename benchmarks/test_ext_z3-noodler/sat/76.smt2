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

(declare-sort var2684 0)
(declare-sort var364 0)
(declare-sort var676 0)
(declare-sort var826 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun configuratorUrl/338141869 (var2684) var364)
(declare-fun getParameter/2144001655 (var364 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var826) String)
(declare-fun cast-from-var364-to-var826 (var364) var826)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var676_info/484404803 (var676 String) void)
(declare-const null-var2684 var2684)
(declare-const null-var364 var364)
(declare-const var2684-logger var676)
(declare-const var2867 var2684) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator 
(assert (not (= var2867 null-var2684)))
(declare-const var2842 var364) ; Statement: r14 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2842 null-var364)))
(define-const var1395 var364 (configuratorUrl/338141869 var2867)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var3525 Bool (getParameter/2144001655 var1395 "enabled" (ite (= 1 1) true false))) ; Statement: $z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("enabled", 1) 
 ; Statement: if $z0 == 0 goto $r15 = <org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.logger.Logger logger> 
(assert (= (ite var3525 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3037 var676 var2684-logger) ; Statement: $r15 = <org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.logger.Logger logger> 
(define-const var2659 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2659)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2659!1 String)
(assert (= var2659!1 ""))
(assert true)
(define-const var1886 String (append/672562846 var2659!1 "Cannot apply configurator rule, the rule is disabled or is invalid: \n")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cannot apply configurator rule, the rule is disabled or is invalid: \n") 
(declare-const var2659!2 String)
(assert (= var2659!2 (str.++ var2659!1 "Cannot apply configurator rule, the rule is disabled or is invalid: \n")))
(define-const var1906 var364 (configuratorUrl/338141869 var2867)) ; Statement: $r18 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var2484 String (append/-1031950772 var1886 (cast-from-var364-to-var826 var1906))) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r18) 
(declare-const var1886!1 String)
(assert (str.prefixof var1886 var1886!1))
(assert true)
(define-const var898 String (toString/-2075883882 var2484)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var676_info/484404803 var3037 var898)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r20) 

(declare-const var3037!1 var676)
(declare-const var898!1 String)
 ; Statement: return r14 
(check-sat)
; {configuratorUrl/338141869=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator], org.apache.dubbo.common.URL), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var364-to-var826=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var676_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void)}
; {var2684=org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, var2867=r0, var364=org.apache.dubbo.common.URL, var2842=r14, var1395=$r1, var3525=$z0, var676=org.apache.dubbo.common.logger.Logger, var3037=$r15, var2659=$r16, var1886=$r17, var1906=$r18, var826=java.lang.Object, var2484=$r19, var898=$r20}
; {org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator=var2684, r0=var2867, org.apache.dubbo.common.URL=var364, r14=var2842, $r1=var1395, $z0=var3525, org.apache.dubbo.common.logger.Logger=var676, $r15=var3037, $r16=var2659, $r17=var1886, $r18=var1906, java.lang.Object=var826, $r19=var2484, $r20=var898}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator;	r14 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$z0 = virtualinvoke $r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("enabled", 1);	if $z0 == 0 goto $r15 = <org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.logger.Logger logger>;	$r15 = <org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.logger.Logger logger>;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cannot apply configurator rule, the rule is disabled or is invalid: \n");	$r18 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r18);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r20);	return r14
;block_num 2