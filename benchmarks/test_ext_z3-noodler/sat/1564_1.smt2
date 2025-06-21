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

(declare-sort var2019 0)
(declare-sort var2279 0)
(declare-sort var1981 0)
(declare-sort var2663 0)
(declare-sort var2058 0)
(declare-sort var3562 0)
(declare-sort var393 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toPath/-1698179320 (var2019) var2279)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getAbsolutePath/-802773300 (var2019) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3562_debug/-407276736 (var3562 String var393) void)
(declare-fun cast-from-var2663-to-var3562 (var2663) var3562)
(declare-fun cast-from-var1981-to-var393 (var1981) var393)
(declare-const null-var2019 var2019)
(declare-const null-var1981 var1981)
(declare-const var2058-logger var2663)
(declare-const var2438 var2019) ; Statement: r0 := @parameter0: java.io.File 
(assert (not (= var2438 null-var2019)))
(assert true)
(define-const var3389 var2279 (toPath/-1698179320 var2438)) ; Statement: r1 = virtualinvoke r0.<java.io.File: java.nio.file.Path toPath()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var206 var1981) ; Statement: $r2 := @caughtexception 
(assert (not (= var206 null-var1981)))
(define-const var1446 var2663 var2058-logger) ; Statement: $r4 = <org.apache.dubbo.common.cache.FileCacheStore: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var228 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var228)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var228!1 String)
(assert (= var228!1 ""))
(assert true)
(define-const var218 String (append/672562846 var228!1 "Failed to delete file ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to delete file ") 
(declare-const var228!2 String)
(assert (= var228!2 (str.++ var228!1 "Failed to delete file ")))
(assert true)
(define-const var297 String (getAbsolutePath/-802773300 var2438)) ; Statement: $r5 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert true)
(define-const var3246 String (append/672562846 var218 var297)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var218!1 String)
(assert (= var218!1 (str.++ var218 var297)))
(assert true)
(define-const var1346 String (toString/-2075883882 var3246)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3562_debug/-407276736 (cast-from-var2663-to-var3562 var1446) var1346 (cast-from-var1981-to-var393 var206))) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>($r8, $r2) 

(declare-const var1446!1 var2663)
(declare-const var1346!1 String)
(declare-const var206!1 var1981)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {toPath/-1698179320=([java.io.File], java.nio.file.Path), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getAbsolutePath/-802773300=([java.io.File], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3562_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var2663-to-var3562=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), cast-from-var1981-to-var393=([java.io.IOException], java.lang.Throwable)}
; {var2019=java.io.File, var2438=r0, var2279=java.nio.file.Path, var3389=r1, var1981=java.io.IOException, var206=$r2, var2663=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2058=org.apache.dubbo.common.cache.FileCacheStore, var1446=$r4, var228=$r3, var218=$r6, var297=$r5, var3246=$r7, var1346=$r8, var3562=org.apache.dubbo.common.logger.Logger, var393=java.lang.Throwable}
; {java.io.File=var2019, r0=var2438, java.nio.file.Path=var2279, r1=var3389, java.io.IOException=var1981, $r2=var206, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2663, org.apache.dubbo.common.cache.FileCacheStore=var2058, $r4=var1446, $r3=var228, $r6=var218, $r5=var297, $r7=var3246, $r8=var1346, org.apache.dubbo.common.logger.Logger=var3562, java.lang.Throwable=var393}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.io.File;	r1 = virtualinvoke r0.<java.io.File: java.nio.file.Path toPath()>();	$r2 := @caughtexception;	$r4 = <org.apache.dubbo.common.cache.FileCacheStore: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to delete file ");	$r5 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>($r8, $r2);	return
;block_num 3