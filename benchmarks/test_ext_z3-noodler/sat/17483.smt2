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

(declare-sort var731 0)
(declare-sort var763 0)
(declare-sort var1656 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1656!class ClassObject)
(declare-fun var763_getErrorTypeAwareLogger/453021605 (ClassObject) var731)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(define-const var3655 var731 (var763_getErrorTypeAwareLogger/453021605 var1656!class)) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/exchange/support/header/HeaderExchangeChannel;") 
(define-const var1860 var731 var3655) ; Statement: <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0 
(define-const var169 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var169)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var169!1 String)
(assert (= var169!1 ""))
(define-const var3768 ClassObject var1656!class) ; Statement: $r2 = class "Lorg/apache/dubbo/remoting/exchange/support/header/HeaderExchangeChannel;" 
(assert true)
(define-const var2249 String (getName/-1958580599 var3768)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1868 String (append/672562846 var169!1 var2249)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var169!2 String)
(assert (= var169!2 (str.++ var169!1 var2249)))
(assert true)
(define-const var3787 String (append/672562846 var1868 ".CHANNEL")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".CHANNEL") 
(declare-const var1868!1 String)
(assert (= var1868!1 (str.++ var1868 ".CHANNEL")))
(assert true)
(define-const var1424 String (toString/-2075883882 var3787)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3070 String var1424) ; Statement: <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.lang.String CHANNEL_KEY> = $r6 
 ; Statement: return 
(check-sat)
; {var763_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var731=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var763=org.apache.dubbo.common.logger.LoggerFactory, var1656=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel, var3655=$r0, var1860=<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>, var169=$r1, var3768=$r2, var2249=$r3, var1868=$r4, var3787=$r5, var1424=$r6, var3070=<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.lang.String CHANNEL_KEY>}
; {org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var731, org.apache.dubbo.common.logger.LoggerFactory=var763, org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel=var1656, $r0=var3655, <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>=var1860, $r1=var169, $r2=var3768, $r3=var2249, $r4=var1868, $r5=var3787, $r6=var1424, <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.lang.String CHANNEL_KEY>=var3070}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/exchange/support/header/HeaderExchangeChannel;");	<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = class "Lorg/apache/dubbo/remoting/exchange/support/header/HeaderExchangeChannel;";	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".CHANNEL");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.lang.String CHANNEL_KEY> = $r6;	return
;block_num 1