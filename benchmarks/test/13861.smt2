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

(declare-sort var1180 0)
(declare-sort var2078 0)
(declare-sort var3940 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun interceptor/-1665773367 (var1180) var2078)
(declare-fun append/-1031950772 (String var3940) String)
(declare-fun cast-from-var2078-to-var3940 (var2078) var3940)
(declare-fun getPriority/187786879 (var1180) Int)
(declare-fun getPatterns/1287258514 (var1180) (Array Int String))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1180 var1180)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3730 var1180) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter 
(assert (not (= var3730 null-var1180)))
(define-const var1365 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1365 "RestFilter{interceptor=")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{interceptor=") 
(declare-const var1365!1 String)
(assert (= var1365!1 "RestFilter{interceptor="))
(define-const var3711 var2078 (interceptor/-1665773367 var3730)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: org.springframework.web.servlet.HandlerInterceptor interceptor> 
(assert true)
;(assert (append/-1031950772 var1365!1 (cast-from-var2078-to-var3940 var3711))) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1365!2 String)
(assert (str.prefixof var1365!1 var1365!2))
(assert true)
(define-const var3480 Int (getPriority/187786879 var3730)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: int getPriority()>() 
 ; Statement: if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: java.lang.String[] getPatterns()>() 
(assert (= var3480 0)) ; Cond: i0 == 0 
(assert true)
(define-const var1758 (Array Int String) (getPatterns/1287258514 var3730)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: java.lang.String[] getPatterns()>() 
 ; Statement: if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var1758 null-__Array__Int__String__)) ; Cond: $r8 == null 
(assert true)
(define-const var3830 String (append/-1166366385 var1365!2 125)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1365!3 String)
(assert (str.prefixof var1365!2 var1365!3))
(assert true)
(define-const var1541 String (toString/-2075883882 var3830)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), interceptor/-1665773367=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter], org.springframework.web.servlet.HandlerInterceptor), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2078-to-var3940=([org.springframework.web.servlet.HandlerInterceptor], java.lang.Object), getPriority/187786879=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter], int), getPatterns/1287258514=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter], java.lang.String[]), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1180=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter, var3730=r1, var1365=$r0, var2078=org.springframework.web.servlet.HandlerInterceptor, var3711=$r2, var3940=java.lang.Object, var3480=i0, var1758=$r8, var3830=$r3, var1541=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter=var1180, r1=var3730, $r0=var1365, org.springframework.web.servlet.HandlerInterceptor=var2078, $r2=var3711, java.lang.Object=var3940, i0=var3480, $r8=var1758, $r3=var3830, $r4=var1541}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{interceptor=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: org.springframework.web.servlet.HandlerInterceptor interceptor>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: int getPriority()>();	if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: java.lang.String[] getPatterns()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.HandlerInterceptorAdapter$HandlerInterceptorRestFilter: java.lang.String[] getPatterns()>();	if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3