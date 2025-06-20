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

(declare-sort var455 0)
(declare-sort var3933 0)
(declare-sort var3501 0)
(declare-sort var2282 0)
(declare-sort var1276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var1276) String)
(declare-fun cast-from-var3501-to-var1276 (var3501) var1276)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2282_error/377575788 (var2282 String String String String var1276) void)
(declare-const null-var455 var455)
(declare-const null-var3933 var3933)
(declare-const null-var3501 var3501)
(declare-const var455-logger var2282)
(declare-const var3309 var455) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager 
(assert (not (= var3309 null-var455)))
(declare-const var802 var3933) ; Statement: r8 := @parameter1: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var802 null-var3933)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3987 var3501) ; Statement: $r1 := @caughtexception 
(assert (not (= var3987 null-var3501)))
(define-const var3618 var2282 var455-logger) ; Statement: $r3 = <org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var651 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var651)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var651!1 String)
(assert (= var651!1 ""))
(assert true)
(define-const var1564 String (append/672562846 var651!1 "Error encountered while destroying ZookeeperTransporter: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error encountered while destroying ZookeeperTransporter: ") 
(declare-const var651!2 String)
(assert (= var651!2 (str.++ var651!1 "Error encountered while destroying ZookeeperTransporter: ")))
(assert true)
(define-const var2329 String (getMessage/849299655 (cast-from-var3501-to-var1276 var3987))) ; Statement: $r4 = virtualinvoke $r1.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var551 String (append/672562846 var1564 var2329)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1564!1 String)
(assert (= var1564!1 (str.++ var1564 var2329)))
(assert true)
(define-const var3118 String (toString/-2075883882 var551)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2282_error/377575788 var3618 "6-12" "" "" var3118 (cast-from-var3501-to-var1276 var3987))) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-12", "", "", $r7, $r1) 

(declare-const var3618!1 var2282)
(declare-const var1414 String)
(declare-const var3290 String)
(declare-const var3290!1 String)
(declare-const var3118!1 String)
(declare-const var3987!1 var3501)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3501-to-var1276=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2282_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var455=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager, var3309=r0, var3933=org.apache.dubbo.rpc.model.ScopeModel, var802=r8, var3501=java.lang.Exception, var3987=$r1, var2282=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3618=$r3, var651=$r2, var1564=$r5, var1276=java.lang.Throwable, var2329=$r4, var551=$r6, var3118=$r7, var1414="6-12", var3290=""}
; {org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager=var455, r0=var3309, org.apache.dubbo.rpc.model.ScopeModel=var3933, r8=var802, java.lang.Exception=var3501, $r1=var3987, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2282, $r3=var3618, $r2=var651, $r5=var1564, java.lang.Throwable=var1276, $r4=var2329, $r6=var551, $r7=var3118, "6-12"=var1414, ""=var3290}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager;	r8 := @parameter1: org.apache.dubbo.rpc.model.ScopeModel;	$r1 := @caughtexception;	$r3 = <org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error encountered while destroying ZookeeperTransporter: ");	$r4 = virtualinvoke $r1.<java.lang.Exception: java.lang.String getMessage()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-12", "", "", $r7, $r1);	return
;block_num 3