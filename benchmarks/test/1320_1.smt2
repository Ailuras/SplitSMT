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

(declare-sort var953 0)
(declare-sort var2339 0)
(declare-sort var2398 0)
(declare-sort var529 0)
(declare-sort var139 0)
(declare-sort var869 0)
(declare-sort var3913 0)
(declare-sort var3343 0)
(declare-sort var1727 0)
(declare-sort var1953 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var2339-init () var2339)
(declare-fun <init>/-1681595970 (var2339 String) void)
(declare-fun toPath/-1698179320 (var2339) var2398)
(declare-fun isDirectory/-2122094196 (var2339) Bool)
(declare-fun arr-var529-init () (Array Int var529))
(declare-fun var869_error/377575788 (var869 String String String String var3343) void)
(declare-fun cast-from-var139-to-var3343 (var139) var3343)
(declare-fun var1727-init () var1727)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1953) String)
(declare-fun cast-from-var2339-to-var1953 (var2339) var1953)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1642269841 (var1727 String var3343) void)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2339-separator String)
(declare-const null-var139 var139)
(declare-const var3913-logger var869)
(declare-const var3558 String) ; Statement: r31 := @parameter0: java.lang.String 
(assert (not (= var3558 null-String)))
(declare-const var570 String) ; Statement: r32 := @parameter1: java.lang.String 
(assert (not (= var570 null-String)))
(declare-const var2356 Bool) ; Statement: z3 := @parameter2: boolean 
(assert (not (= var2356 null-Bool)))
 ; Statement: if r31 != null goto $r0 = <java.io.File: java.lang.String separator> 
(assert (not (= var3558 null-String))) ; Cond: r31 != null 
(define-const var263 String var2339-separator) ; Statement: $r0 = <java.io.File: java.lang.String separator> 
(assert true)
(define-const var1046 Bool (endsWith/985337093 var3558 var263)) ; Statement: $z0 = virtualinvoke r31.<java.lang.String: boolean endsWith(java.lang.String)>($r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.io.File 
(assert (= (ite var1046 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1464 var2339 var2339-init) ; Statement: $r1 = new java.io.File 
(assert true)
;(assert (<init>/-1681595970 var1464 var3558)) ; Statement: specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>(r31) 

(declare-const var1464!1 var2339)
(declare-const var3558!1 String)
(assert true)
(define-const var177 var2398 (toPath/-1698179320 var1464!1)) ; Statement: $r17 = virtualinvoke $r1.<java.io.File: java.nio.file.Path toPath()>() 
(assert true)
(define-const var6 Bool (isDirectory/-2122094196 var1464!1)) ; Statement: $z1 = virtualinvoke $r1.<java.io.File: boolean isDirectory()>() 
 ; Statement: if $z1 != 0 goto $r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32) 
(assert (not (not (= (ite var6 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var3029 (Array Int var529) arr-var529-init) ; Statement: $r15 = newarray (java.nio.file.attribute.FileAttribute)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var575 var139) ; Statement: $r24 := @caughtexception 
(assert (not (= var575 null-var139)))
(define-const var3951 var869 var3913-logger) ; Statement: $r25 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var869_error/377575788 var3951 "0-3" "inaccessible of cache path" "" "Cache store path can\u0027t be created: " (cast-from-var139-to-var3343 var575))) ; Statement: interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-3", "inaccessible of cache path", "", "Cache store path can\'t be created: ", $r24) 

(declare-const var3951!1 var869)
(declare-const var2863 String)
(declare-const var3624 String)
(declare-const var2989 String)
(declare-const var805 String)
(declare-const var575!1 var139)
(define-const var2902 var1727 var1727-init) ; Statement: $r26 = new java.lang.RuntimeException 
(define-const var3241 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3241)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3241!1 String)
(assert (= var3241!1 ""))
(assert true)
(define-const var1548 String (append/672562846 var3241!1 "Cache store path can\u0027t be created: ")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cache store path can\'t be created: ") 
(declare-const var3241!2 String)
(assert (= var3241!2 (str.++ var3241!1 "Cache store path can\u0027t be created: ")))
(assert true)
(define-const var3249 String (append/-1031950772 var1548 (cast-from-var2339-to-var1953 var1464!1))) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r1) 
(declare-const var1548!1 String)
(assert (str.prefixof var1548 var1548!1))
(assert true)
(define-const var1946 String (toString/-2075883882 var3249)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1642269841 var2902 var1946 (cast-from-var139-to-var3343 var575!1))) ; Statement: specialinvoke $r26.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r30, $r24) 

(declare-const var2902!1 var1727)
(declare-const var1946!1 String)
(declare-const var575!2 var139)
 ; Statement: throw $r26 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var2339-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), toPath/-1698179320=([java.io.File], java.nio.file.Path), isDirectory/-2122094196=([java.io.File], boolean), arr-var529-init=([], java.nio.file.attribute.FileAttribute[]), var869_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var139-to-var3343=([java.io.IOException], java.lang.Throwable), var1727-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2339-to-var1953=([java.io.File], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var3558=r31, var953=null_type, var570=r32, var2356=z3, var2339=java.io.File, var263=$r0, var1046=$z0, var1464=$r1, var2398=java.nio.file.Path, var177=$r17, var6=$z1, var529=java.nio.file.attribute.FileAttribute, var3029=$r15, var139=java.io.IOException, var575=$r24, var869=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3913=org.apache.dubbo.common.cache.FileCacheStoreFactory, var3951=$r25, var3343=java.lang.Throwable, var2863="0-3", var3624="inaccessible of cache path", var2989="", var805="Cache store path can\'t be created: ", var1727=java.lang.RuntimeException, var2902=$r26, var3241=$r27, var1548=$r28, var1953=java.lang.Object, var3249=$r29, var1946=$r30}
; {r31=var3558, null_type=var953, r32=var570, z3=var2356, java.io.File=var2339, $r0=var263, $z0=var1046, $r1=var1464, java.nio.file.Path=var2398, $r17=var177, $z1=var6, java.nio.file.attribute.FileAttribute=var529, $r15=var3029, java.io.IOException=var139, $r24=var575, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var869, org.apache.dubbo.common.cache.FileCacheStoreFactory=var3913, $r25=var3951, java.lang.Throwable=var3343, "0-3"=var2863, "inaccessible of cache path"=var3624, ""=var2989, "Cache store path can\'t be created: "=var805, java.lang.RuntimeException=var1727, $r26=var2902, $r27=var3241, $r28=var1548, java.lang.Object=var1953, $r29=var3249, $r30=var1946}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r31 := @parameter0: java.lang.String;	r32 := @parameter1: java.lang.String;	z3 := @parameter2: boolean;	if r31 != null goto $r0 = <java.io.File: java.lang.String separator>;	$r0 = <java.io.File: java.lang.String separator>;	$z0 = virtualinvoke r31.<java.lang.String: boolean endsWith(java.lang.String)>($r0);	if $z0 == 0 goto $r1 = new java.io.File;	$r1 = new java.io.File;	specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>(r31);	$r17 = virtualinvoke $r1.<java.io.File: java.nio.file.Path toPath()>();	$z1 = virtualinvoke $r1.<java.io.File: boolean isDirectory()>();	if $z1 != 0 goto $r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32);	$r15 = newarray (java.nio.file.attribute.FileAttribute)[0];	$r24 := @caughtexception;	$r25 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-3", "inaccessible of cache path", "", "Cache store path can\'t be created: ", $r24);	$r26 = new java.lang.RuntimeException;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cache store path can\'t be created: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r1);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r30, $r24);	throw $r26
;block_num 5