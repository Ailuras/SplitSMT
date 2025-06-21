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

(declare-sort var2735 0)
(declare-sort var281 0)
(declare-sort var3116 0)
(declare-sort var136 0)
(declare-sort var3952 0)
(declare-sort var576 0)
(declare-sort var2116 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var3952) String)
(declare-fun cast-from-var3116-to-var3952 (var3116) var3952)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var136_error/377575788 (var136 String String String String var3952) void)
(declare-fun getApplicationContext/729154120 (var281) var576)
(declare-fun var2116_remove/-212668533 (var576) Bool)
(declare-const null-var2735 var2735)
(declare-const null-var281 var281)
(declare-const null-var3116 var3116)
(declare-const var2735-logger var136)
(declare-const var3838 var2735) ; Statement: r0 := @this: org.apache.dubbo.config.spring.context.DubboDeployApplicationListener 
(assert (not (= var3838 null-var2735)))
(declare-const var2376 var281) ; Statement: r3 := @parameter0: org.springframework.context.event.ContextClosedEvent 
(assert (not (= var2376 null-var281)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1166 var3116) ; Statement: $r8 := @caughtexception 
(assert (not (= var1166 null-var3116)))
(define-const var2497 var136 var2735-logger) ; Statement: $r10 = <org.apache.dubbo.config.spring.context.DubboDeployApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1226 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1226)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1226!1 String)
(assert (= var1226!1 ""))
(assert true)
(define-const var188 String (append/672562846 var1226!1 "Unexpected error occurred when stop dubbo module: ")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when stop dubbo module: ") 
(declare-const var1226!2 String)
(assert (= var1226!2 (str.++ var1226!1 "Unexpected error occurred when stop dubbo module: ")))
(assert true)
(define-const var442 String (getMessage/849299655 (cast-from-var3116-to-var3952 var1166))) ; Statement: $r11 = virtualinvoke $r8.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var3179 String (append/672562846 var188 var442)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var188!1 String)
(assert (= var188!1 (str.++ var188 var442)))
(assert true)
(define-const var3758 String (toString/-2075883882 var3179)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var136_error/377575788 var2497 "5-20" "" "" var3758 (cast-from-var3116-to-var3952 var1166))) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-20", "", "", $r14, $r8) 

(declare-const var2497!1 var136)
(declare-const var2184 String)
(declare-const var3797 String)
(declare-const var3797!1 String)
(declare-const var3758!1 String)
(declare-const var1166!1 var3116)
(assert true) ; Non Conditional
(assert true)
(define-const var329 var576 (getApplicationContext/729154120 var2376)) ; Statement: $r4 = virtualinvoke r3.<org.springframework.context.event.ContextClosedEvent: org.springframework.context.ApplicationContext getApplicationContext()>() 
;(assert (var2116_remove/-212668533 var329)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: boolean remove(org.springframework.context.ApplicationContext)>($r4) 

(declare-const var329!1 var576)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3116-to-var3952=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var136_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), getApplicationContext/729154120=([org.springframework.context.event.ContextClosedEvent], org.springframework.context.ApplicationContext), var2116_remove/-212668533=([org.springframework.context.ApplicationContext], boolean)}
; {var2735=org.apache.dubbo.config.spring.context.DubboDeployApplicationListener, var3838=r0, var281=org.springframework.context.event.ContextClosedEvent, var2376=r3, var3116=java.lang.Exception, var1166=$r8, var136=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2497=$r10, var1226=$r9, var188=$r12, var3952=java.lang.Throwable, var442=$r11, var3179=$r13, var3758=$r14, var2184="5-20", var3797="", var576=org.springframework.context.ApplicationContext, var329=$r4, var2116=org.apache.dubbo.config.spring.context.DubboSpringInitializer}
; {org.apache.dubbo.config.spring.context.DubboDeployApplicationListener=var2735, r0=var3838, org.springframework.context.event.ContextClosedEvent=var281, r3=var2376, java.lang.Exception=var3116, $r8=var1166, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var136, $r10=var2497, $r9=var1226, $r12=var188, java.lang.Throwable=var3952, $r11=var442, $r13=var3179, $r14=var3758, "5-20"=var2184, ""=var3797, org.springframework.context.ApplicationContext=var576, $r4=var329, org.apache.dubbo.config.spring.context.DubboSpringInitializer=var2116}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.context.DubboDeployApplicationListener;	r3 := @parameter0: org.springframework.context.event.ContextClosedEvent;	$r8 := @caughtexception;	$r10 = <org.apache.dubbo.config.spring.context.DubboDeployApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when stop dubbo module: ");	$r11 = virtualinvoke $r8.<java.lang.Exception: java.lang.String getMessage()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-20", "", "", $r14, $r8);	$r4 = virtualinvoke r3.<org.springframework.context.event.ContextClosedEvent: org.springframework.context.ApplicationContext getApplicationContext()>();	staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: boolean remove(org.springframework.context.ApplicationContext)>($r4);	return
;block_num 3