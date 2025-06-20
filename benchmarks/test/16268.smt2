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

(declare-sort var1195 0)
(declare-sort var1873 0)
(declare-sort var144 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var1873) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var144_error/377575788 (var144 String String String String var1873) void)
(declare-const null-var1195 var1195)
(declare-const null-var1873 var1873)
(declare-const var1195-logger var144)
(declare-const var2251 var1195) ; Statement: r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var2251 null-var1195)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1122 var1873) ; Statement: $r1 := @caughtexception 
(assert (not (= var1122 null-var1873)))
(define-const var170 var144 var1195-logger) ; Statement: $r3 = <org.apache.dubbo.registry.multicast.MulticastRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3698 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3698)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3698!1 String)
(assert (= var3698!1 ""))
(assert true)
(define-const var2328 String (append/672562846 var3698!1 "Unexpected exception occur at clean expired provider, cause: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected exception occur at clean expired provider, cause: ") 
(declare-const var3698!2 String)
(assert (= var3698!2 (str.++ var3698!1 "Unexpected exception occur at clean expired provider, cause: ")))
(assert true)
(define-const var3393 String (getMessage/849299655 var1122)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1836 String (append/672562846 var2328 var3393)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2328!1 String)
(assert (= var2328!1 (str.++ var2328 var3393)))
(assert true)
(define-const var1967 String (toString/-2075883882 var1836)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var144_error/377575788 var170 "1-38" "" "" var1967 var1122)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-38", "", "", $r7, $r1) 

(declare-const var170!1 var144)
(declare-const var2845 String)
(declare-const var3821 String)
(declare-const var3821!1 String)
(declare-const var1967!1 String)
(declare-const var1122!1 var1873)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var144_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1195=org.apache.dubbo.registry.multicast.MulticastRegistry, var2251=r0, var1873=java.lang.Throwable, var1122=$r1, var144=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var170=$r3, var3698=$r2, var2328=$r5, var3393=$r4, var1836=$r6, var1967=$r7, var2845="1-38", var3821=""}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var1195, r0=var2251, java.lang.Throwable=var1873, $r1=var1122, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var144, $r3=var170, $r2=var3698, $r5=var2328, $r4=var3393, $r6=var1836, $r7=var1967, "1-38"=var2845, ""=var3821}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	$r1 := @caughtexception;	$r3 = <org.apache.dubbo.registry.multicast.MulticastRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected exception occur at clean expired provider, cause: ");	$r4 = virtualinvoke $r1.<java.lang.Throwable: java.lang.String getMessage()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-38", "", "", $r7, $r1);	return
;block_num 3