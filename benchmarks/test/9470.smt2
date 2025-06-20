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

(declare-sort var65 0)
(declare-sort var2522 0)
(declare-sort var3492 0)
(declare-sort var753 0)
(declare-sort var1270 0)
(declare-sort var2523 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getIdentifier/-338683473 (var753) String)
(declare-fun cast-from-var65-to-var753 (var65) var753)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1270_info/484404803 (var1270 String) void)
(declare-fun cast-from-var3492-to-var1270 (var3492) var1270)
(declare-fun asyncExportingFutures/-1953096320 (var65) var2523)
(declare-fun var2523_clear/2124191932 (var2523) void)
(declare-const null-var65 var65)
(declare-const null-var2522 var2522)
(declare-const var65-logger var3492)
(declare-const var660 var65) ; Statement: r2 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var660 null-var65)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1149 var2522) ; Statement: $r20 := @caughtexception 
(assert (not (= var1149 null-var2522)))
(define-const var711 var3492 var65-logger) ; Statement: $r22 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1547 String String-init) ; Statement: $r21 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1547)) ; Statement: specialinvoke $r21.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1547!1 String)
(assert (= var1547!1 ""))
(assert true)
(define-const var290 String (getIdentifier/-338683473 (cast-from-var65-to-var753 var660))) ; Statement: $r23 = virtualinvoke r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var880 String (append/672562846 var1547!1 var290)) ; Statement: $r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var1547!2 String)
(assert (= var1547!2 (str.++ var1547!1 var290)))
(assert true)
(define-const var2711 String (append/672562846 var880 " export services finished.")) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" export services finished.") 
(declare-const var880!1 String)
(assert (= var880!1 (str.++ var880 " export services finished.")))
(assert true)
(define-const var3585 String (toString/-2075883882 var2711)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1270_info/484404803 (cast-from-var3492-to-var1270 var711) var3585)) ; Statement: interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r26) 

(declare-const var711!1 var3492)
(declare-const var3585!1 String)
(define-const var2375 var2523 (asyncExportingFutures/-1953096320 var660)) ; Statement: $r27 = r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.List asyncExportingFutures> 
;(assert (var2523_clear/2124191932 var2375)) ; Statement: interfaceinvoke $r27.<java.util.List: void clear()>() 

(declare-const var2375!1 var2523)
 ; Statement: throw $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), cast-from-var65-to-var753=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1270_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3492-to-var1270=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), asyncExportingFutures/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], java.util.List), var2523_clear/2124191932=([java.util.List], void)}
; {var65=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var660=r2, var2522=java.lang.Throwable, var1149=$r20, var3492=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var711=$r22, var1547=$r21, var753=org.apache.dubbo.common.deploy.AbstractDeployer, var290=$r23, var880=$r24, var2711=$r25, var3585=$r26, var1270=org.apache.dubbo.common.logger.Logger, var2523=java.util.List, var2375=$r27}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var65, r2=var660, java.lang.Throwable=var2522, $r20=var1149, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3492, $r22=var711, $r21=var1547, org.apache.dubbo.common.deploy.AbstractDeployer=var753, $r23=var290, $r24=var880, $r25=var2711, $r26=var3585, org.apache.dubbo.common.logger.Logger=var1270, java.util.List=var2523, $r27=var2375}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	$r20 := @caughtexception;	$r22 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r21 = new java.lang.StringBuilder;	specialinvoke $r21.<java.lang.StringBuilder: void <init>()>();	$r23 = virtualinvoke r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" export services finished.");	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r26);	$r27 = r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.List asyncExportingFutures>;	interfaceinvoke $r27.<java.util.List: void clear()>();	throw $r20
;block_num 2