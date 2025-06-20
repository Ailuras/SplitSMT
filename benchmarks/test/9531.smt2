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

(declare-sort var1884 0)
(declare-sort var1145 0)
(declare-sort var1750 0)
(declare-sort var3836 0)
(declare-sort var3034 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-955518528 (var1884) var3836)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3034) String)
(declare-fun cast-from-var1145-to-var3034 (var1145) var3034)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3836_error/377575788 (var3836 String String String String var1750) void)
(declare-const null-var1884 var1884)
(declare-const null-var1145 var1145)
(declare-const null-var1750 var1750)
(declare-const var2214 var1884) ; Statement: r0 := @this: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var2214 null-var1884)))
(declare-const var1590 var1145) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var1590 null-var1145)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var962 var1750) ; Statement: $r22 := @caughtexception 
(assert (not (= var962 null-var1750)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3346 var1750) ; Statement: $r9 := @caughtexception 
(assert (not (= var3346 null-var1750)))
(define-const var1083 var3836 (logger/-955518528 var2214)) ; Statement: $r11 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3854 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3854)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3854!1 String)
(assert (= var3854!1 ""))
(assert true)
(define-const var2371 String (append/672562846 var3854!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var3854!2 String)
(assert (= var3854!2 (str.++ var3854!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var1539 String (append/-1031950772 var2371 (cast-from-var1145-to-var3034 var1590))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2371!1 String)
(assert (str.prefixof var2371 var2371!1))
(assert true)
(define-const var1310 String (append/672562846 var1539 " Javassist Error.")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.") 
(declare-const var1539!1 String)
(assert (= var1539!1 (str.++ var1539 " Javassist Error.")))
(assert true)
(define-const var3066 String (toString/-2075883882 var1310)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3836_error/377575788 var1083 "3-8" "" "" var3066 var962)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r15, $r22) 

(declare-const var1083!1 var3836)
(declare-const var1245 String)
(declare-const var938 String)
(declare-const var938!1 String)
(declare-const var3066!1 String)
(declare-const var962!1 var1750)
(define-const var1601 var3836 (logger/-955518528 var2214)) ; Statement: $r17 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2909 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2909)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2909!1 String)
(assert (= var2909!1 ""))
(assert true)
(define-const var31 String (append/672562846 var2909!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var2909!2 String)
(assert (= var2909!2 (str.++ var2909!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var791 String (append/-1031950772 var31 (cast-from-var1145-to-var3034 var1590))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var31!1 String)
(assert (str.prefixof var31 var31!1))
(assert true)
(define-const var3695 String (append/672562846 var791 " JDK Error.")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var791!1 String)
(assert (= var791!1 (str.++ var791 " JDK Error.")))
(assert true)
(define-const var1176 String (toString/-2075883882 var3695)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3836_error/377575788 var1601 "3-8" "" "" var1176 var3346)) ; Statement: interfaceinvoke $r17.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r21, $r9) 

(declare-const var1601!1 var3836)
(declare-const var1245!1 String)
(declare-const var938!2 String)
(declare-const var938!3 String)
(declare-const var1176!1 String)
(declare-const var3346!1 var1750)
 ; Statement: throw $r22 
(check-sat)
; {logger/-955518528=([org.apache.dubbo.config.spring.ReferenceBean], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1145-to-var3034=([java.util.List], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3836_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1884=org.apache.dubbo.config.spring.ReferenceBean, var2214=r0, var1145=java.util.List, var1590=r1, var1750=java.lang.Throwable, var962=$r22, var3346=$r9, var3836=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1083=$r11, var3854=$r10, var2371=$r12, var3034=java.lang.Object, var1539=$r13, var1310=$r14, var3066=$r15, var1245="3-8", var938="", var1601=$r17, var2909=$r16, var31=$r18, var791=$r19, var3695=$r20, var1176=$r21}
; {org.apache.dubbo.config.spring.ReferenceBean=var1884, r0=var2214, java.util.List=var1145, r1=var1590, java.lang.Throwable=var1750, $r22=var962, $r9=var3346, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3836, $r11=var1083, $r10=var3854, $r12=var2371, java.lang.Object=var3034, $r13=var1539, $r14=var1310, $r15=var3066, "3-8"=var1245, ""=var938, $r17=var1601, $r16=var2909, $r18=var31, $r19=var791, $r20=var3695, $r21=var1176}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.config.spring.ReferenceBean;	r1 := @parameter0: java.util.List;	$r22 := @caughtexception;	$r9 := @caughtexception;	$r11 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r15, $r22);	$r17 = r0.<org.apache.dubbo.config.spring.ReferenceBean: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r17.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r21, $r9);	throw $r22
;block_num 3