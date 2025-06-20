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

(declare-sort var1136 0)
(declare-sort var1664 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun interfaceClassName/325878976 (var1136) String)
(declare-fun var1136_append/-1299525038 (String String) void)
(declare-fun version/325878976 (var1136) String)
(declare-fun group/325878976 (var1136) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun environment/325878976 (var1136) var1664)
(declare-fun var1664_resolvePlaceholders/-144060379 (var1664 String) String)
(declare-const null-var1136 var1136)
(declare-const var3956 var1136) ; Statement: r1 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder 
(assert (not (= var3956 null-var1136)))
(define-const var2567 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var2567 "ServiceBean")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("ServiceBean") 
(declare-const var2567!1 String)
(assert (= var2567!1 "ServiceBean"))
(define-const var26 String (interfaceClassName/325878976 var3956)) ; Statement: $r2 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String interfaceClassName> 
;(assert (var1136_append/-1299525038 var2567!1 var26)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r2) 

(declare-const var2567!2 String)
(declare-const var26!1 String)
(define-const var760 String (version/325878976 var3956)) ; Statement: $r3 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String version> 
;(assert (var1136_append/-1299525038 var2567!2 var760)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r3) 

(declare-const var2567!3 String)
(declare-const var760!1 String)
(define-const var2304 String (group/325878976 var3956)) ; Statement: $r4 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String group> 
;(assert (var1136_append/-1299525038 var2567!3 var2304)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r4) 

(declare-const var2567!4 String)
(declare-const var2304!1 String)
(assert true)
(define-const var816 String (toString/-2075883882 var2567!4)) ; Statement: r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3778 var1664 (environment/325878976 var3956)) ; Statement: $r6 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: org.springframework.core.env.Environment environment> 
(define-const var2602 String (var1664_resolvePlaceholders/-144060379 var3778 var816)) ; Statement: $r7 = interfaceinvoke $r6.<org.springframework.core.env.Environment: java.lang.String resolvePlaceholders(java.lang.String)>(r5) 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), interfaceClassName/325878976=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder], java.lang.String), var1136_append/-1299525038=([java.lang.StringBuilder, java.lang.String], void), version/325878976=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder], java.lang.String), group/325878976=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), environment/325878976=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder], org.springframework.core.env.Environment), var1664_resolvePlaceholders/-144060379=([org.springframework.core.env.Environment, java.lang.String], java.lang.String)}
; {var1136=org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder, var3956=r1, var2567=$r0, var26=$r2, var760=$r3, var2304=$r4, var816=r5, var1664=org.springframework.core.env.Environment, var3778=$r6, var2602=$r7}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder=var1136, r1=var3956, $r0=var2567, $r2=var26, $r3=var760, $r4=var2304, r5=var816, org.springframework.core.env.Environment=var1664, $r6=var3778, $r7=var2602}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceBeanNameBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("ServiceBean");	$r2 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String interfaceClassName>;	staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r2);	$r3 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String version>;	staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r3);	$r4 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: java.lang.String group>;	staticinvoke <org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: void append(java.lang.StringBuilder,java.lang.String)>($r0, $r4);	r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = r1.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceBeanNameBuilder: org.springframework.core.env.Environment environment>;	$r7 = interfaceinvoke $r6.<org.springframework.core.env.Environment: java.lang.String resolvePlaceholders(java.lang.String)>(r5);	return $r7
;block_num 1