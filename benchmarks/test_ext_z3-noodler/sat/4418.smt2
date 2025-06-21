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

(declare-sort var1020 0)
(declare-sort var3389 0)
(declare-sort var2721 0)
(declare-sort var2316 0)
(declare-sort var2621 0)
(declare-sort var182 0)
(declare-sort var2377 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var3389-init () var3389)
(declare-fun var2721-init () var2721)
(declare-fun var2621_error/377575788 (var2621 String String String String var2377) void)
(declare-fun cast-from-var2316-to-var2377 (var2316) var2377)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1020 var1020)
(declare-const null-var2316 var2316)
(declare-const var182-logger var2621)
(declare-const var907 var1020) ; Statement: r3 := @parameter0: java.io.InputStream 
(assert (not (= var907 null-var1020)))
(define-const var2905 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2905)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2905!1 String)
(assert (= var2905!1 ""))
(define-const var2314 (Array Int Int) arr-Int-init) ; Statement: r10 = newarray (char)[10] 
(define-const var2757 var3389 var3389-init) ; Statement: $r13 = new java.io.BufferedReader 
(define-const var3631 var2721 var2721-init) ; Statement: $r12 = new java.io.InputStreamReader 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2785 var2316) ; Statement: $r6 := @caughtexception 
(assert (not (= var2785 null-var2316)))
(define-const var1651 var2621 var182-logger) ; Statement: $r7 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2621_error/377575788 var1651 "0-22" "" "" "Read migration file error." (cast-from-var2316-to-var2377 var2785))) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", "Read migration file error.", $r6) 

(declare-const var1651!1 var2621)
(declare-const var1610 String)
(declare-const var487 String)
(declare-const var487!1 String)
(declare-const var209 String)
(declare-const var2785!1 var2316)
(assert true) ; Non Conditional
(assert true)
(define-const var3694 String (toString/-2075883882 var2905!1)) ; Statement: $r4 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-Int-init=([], char[]), var3389-init=([], java.io.BufferedReader), var2721-init=([], java.io.InputStreamReader), var2621_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2316-to-var2377=([java.io.IOException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1020=java.io.InputStream, var907=r3, var2905=$r11, var2314=r10, var3389=java.io.BufferedReader, var2757=$r13, var2721=java.io.InputStreamReader, var3631=$r12, var2316=java.io.IOException, var2785=$r6, var2621=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var182=org.apache.dubbo.common.utils.ConfigUtils, var1651=$r7, var2377=java.lang.Throwable, var1610="0-22", var487="", var209="Read migration file error.", var3694=$r4}
; {java.io.InputStream=var1020, r3=var907, $r11=var2905, r10=var2314, java.io.BufferedReader=var3389, $r13=var2757, java.io.InputStreamReader=var2721, $r12=var3631, java.io.IOException=var2316, $r6=var2785, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2621, org.apache.dubbo.common.utils.ConfigUtils=var182, $r7=var1651, java.lang.Throwable=var2377, "0-22"=var1610, ""=var487, "Read migration file error."=var209, $r4=var3694}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.io.InputStream;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	r10 = newarray (char)[10];	$r13 = new java.io.BufferedReader;	$r12 = new java.io.InputStreamReader;	$r6 := @caughtexception;	$r7 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", "Read migration file error.", $r6);	$r4 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3