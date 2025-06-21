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

(declare-sort var547 0)
(declare-sort var3714 0)
(declare-sort var615 0)
(declare-sort var3242 0)
(declare-sort var3441 0)
(declare-sort var1601 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun needRefresh/-1098398454 (var547) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3242) String)
(declare-fun cast-from-var547-to-var3242 (var547) var3242)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var615_error/377575788 (var615 String String String String var3441) void)
(declare-fun cast-from-var3714-to-var3441 (var3714) var3441)
(declare-fun var1601-init () var1601)
(declare-fun <init>/-1447874194 (var1601 String var3441) void)
(declare-const null-var547 var547)
(declare-const null-var3714 var3714)
(declare-const var547-logger var615)
(declare-const var3160 var547) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3160 null-var547)))
(define-const var3483 Bool (needRefresh/-1098398454 var3160)) ; Statement: $z0 = r0.<org.apache.dubbo.config.AbstractConfig: boolean needRefresh> 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.config.AbstractConfig: java.util.concurrent.atomic.AtomicBoolean refreshed> 
(assert (not (= (ite var3483 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var2839 var3714) ; Statement: $r4 := @caughtexception 
(assert (not (= var2839 null-var3714)))
(define-const var3913 var615 var547-logger) ; Statement: $r6 = <org.apache.dubbo.config.AbstractConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2304 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2304)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2304!1 String)
(assert (= var2304!1 ""))
(assert true)
(define-const var724 String (append/672562846 var2304!1 "Failed to override field value of config bean: ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to override field value of config bean: ") 
(declare-const var2304!2 String)
(assert (= var2304!2 (str.++ var2304!1 "Failed to override field value of config bean: ")))
(assert true)
(define-const var3297 String (append/-1031950772 var724 (cast-from-var547-to-var3242 var3160))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var724!1 String)
(assert (str.prefixof var724 var724!1))
(assert true)
(define-const var3811 String (toString/-2075883882 var3297)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var615_error/377575788 var3913 "0-24" "" "" var3811 (cast-from-var3714-to-var3441 var2839))) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-24", "", "", $r9, $r4) 

(declare-const var3913!1 var615)
(declare-const var1966 String)
(declare-const var3165 String)
(declare-const var3165!1 String)
(declare-const var3811!1 String)
(declare-const var2839!1 var3714)
(define-const var1622 var1601 var1601-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(define-const var2974 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2974)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2974!1 String)
(assert (= var2974!1 ""))
(assert true)
(define-const var1341 String (append/672562846 var2974!1 "Failed to override field value of config bean: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to override field value of config bean: ") 
(declare-const var2974!2 String)
(assert (= var2974!2 (str.++ var2974!1 "Failed to override field value of config bean: ")))
(assert true)
(define-const var79 String (append/-1031950772 var1341 (cast-from-var547-to-var3242 var3160))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var1341!1 String)
(assert (str.prefixof var1341 var1341!1))
(assert true)
(define-const var816 String (toString/-2075883882 var79)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1622 var816 (cast-from-var3714-to-var3441 var2839!1))) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r14, $r4) 

(declare-const var1622!1 var1601)
(declare-const var816!1 String)
(declare-const var2839!2 var3714)
 ; Statement: throw $r10 
(check-sat)
; {needRefresh/-1098398454=([org.apache.dubbo.config.AbstractConfig], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var547-to-var3242=([org.apache.dubbo.config.AbstractConfig], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var615_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var3714-to-var3441=([java.lang.Exception], java.lang.Throwable), var1601-init=([], java.lang.IllegalStateException), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var547=org.apache.dubbo.config.AbstractConfig, var3160=r0, var3483=$z0, var3714=java.lang.Exception, var2839=$r4, var615=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3913=$r6, var2304=$r5, var724=$r7, var3242=java.lang.Object, var3297=$r8, var3811=$r9, var3441=java.lang.Throwable, var1966="0-24", var3165="", var1601=java.lang.IllegalStateException, var1622=$r10, var2974=$r11, var1341=$r12, var79=$r13, var816=$r14}
; {org.apache.dubbo.config.AbstractConfig=var547, r0=var3160, $z0=var3483, java.lang.Exception=var3714, $r4=var2839, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var615, $r6=var3913, $r5=var2304, $r7=var724, java.lang.Object=var3242, $r8=var3297, $r9=var3811, java.lang.Throwable=var3441, "0-24"=var1966, ""=var3165, java.lang.IllegalStateException=var1601, $r10=var1622, $r11=var2974, $r12=var1341, $r13=var79, $r14=var816}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.config.AbstractConfig;	$z0 = r0.<org.apache.dubbo.config.AbstractConfig: boolean needRefresh>;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.config.AbstractConfig: java.util.concurrent.atomic.AtomicBoolean refreshed>;	$r4 := @caughtexception;	$r6 = <org.apache.dubbo.config.AbstractConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to override field value of config bean: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-24", "", "", $r9, $r4);	$r10 = new java.lang.IllegalStateException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to override field value of config bean: ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r14, $r4);	throw $r10
;block_num 2