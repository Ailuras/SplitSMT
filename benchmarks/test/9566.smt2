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

(declare-sort var921 0)
(declare-sort var2857 0)
(declare-sort var1535 0)
(declare-sort var2530 0)
(declare-sort var3917 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-955518528 (var921) var2530)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3917) String)
(declare-fun cast-from-var2857-to-var3917 (var2857) var3917)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2530_error/377575788 (var2530 String String String String var1535) void)
(declare-const null-var921 var921)
(declare-const null-var2857 var2857)
(declare-const null-var1535 var1535)
(declare-const var1628 var921) ; Statement: r0 := @this: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var1628 null-var921)))
(declare-const var3897 var2857) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var3897 null-var2857)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2842 var1535) ; Statement: $r9 := @caughtexception 
(assert (not (= var2842 null-var1535)))
(define-const var1327 var2530 (logger/-955518528 var1628)) ; Statement: $r11 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1342 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1342)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1342!1 String)
(assert (= var1342!1 ""))
(assert true)
(define-const var3741 String (append/672562846 var1342!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var1342!2 String)
(assert (= var1342!2 (str.++ var1342!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var2004 String (append/-1031950772 var3741 (cast-from-var2857-to-var3917 var3897))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3741!1 String)
(assert (str.prefixof var3741 var3741!1))
(assert true)
(define-const var1371 String (append/672562846 var2004 " JDK Error.")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var2004!1 String)
(assert (= var2004!1 (str.++ var2004 " JDK Error.")))
(assert true)
(define-const var2497 String (toString/-2075883882 var1371)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2530_error/377575788 var1327 "3-8" "" "" var2497 var2842)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r15, $r9) 

(declare-const var1327!1 var2530)
(declare-const var2285 String)
(declare-const var2311 String)
(declare-const var2311!1 String)
(declare-const var2497!1 String)
(declare-const var2842!1 var1535)
 ; Statement: throw $r9 
(check-sat)
; {logger/-955518528=([org.apache.dubbo.config.spring.ReferenceBean], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2857-to-var3917=([java.util.List], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2530_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var921=org.apache.dubbo.config.spring.ReferenceBean, var1628=r0, var2857=java.util.List, var3897=r1, var1535=java.lang.Throwable, var2842=$r9, var2530=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1327=$r11, var1342=$r10, var3741=$r12, var3917=java.lang.Object, var2004=$r13, var1371=$r14, var2497=$r15, var2285="3-8", var2311=""}
; {org.apache.dubbo.config.spring.ReferenceBean=var921, r0=var1628, java.util.List=var2857, r1=var3897, java.lang.Throwable=var1535, $r9=var2842, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2530, $r11=var1327, $r10=var1342, $r12=var3741, java.lang.Object=var3917, $r13=var2004, $r14=var1371, $r15=var2497, "3-8"=var2285, ""=var2311}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.ReferenceBean;	r1 := @parameter0: java.util.List;	$r9 := @caughtexception;	$r11 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r15, $r9);	throw $r9
;block_num 2