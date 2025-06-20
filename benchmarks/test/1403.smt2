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

(declare-sort var278 0)
(declare-sort var1054 0)
(declare-sort var1357 0)
(declare-sort var3177 0)
(declare-sort var491 0)
(declare-sort var160 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun matcher/468719934 (var3177 String) var491)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun find/1809080823 (var491) Bool)
(declare-fun var160-init () var160)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var160 String) void)
(declare-const null-var278 var278)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var1357 var1357)
(declare-const var278-PACKAGE_PATTERN var3177)
(declare-const var278-CLASS_PATTERN var3177)
(declare-const var803 var278) ; Statement: r37 := @this: org.apache.dubbo.common.compiler.support.AbstractCompiler 
(assert (not (= var803 null-var278)))
(declare-const var455 ClassObject) ; Statement: r38 := @parameter0: java.lang.Class 
(assert (not (= var455 null-ClassObject)))
(declare-const var2300 String) ; Statement: r45 := @parameter1: java.lang.String 
(assert (not (= var2300 null-String)))
(declare-const var1306 var1357) ; Statement: r9 := @parameter2: java.lang.ClassLoader 
(assert (not (= var1306 null-var1357)))
(assert true)
(define-const var2585 String (trim/-847153721 var2300)) ; Statement: r46 = virtualinvoke r45.<java.lang.String: java.lang.String trim()>() 
(define-const var2733 var3177 var278-PACKAGE_PATTERN) ; Statement: $r0 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern PACKAGE_PATTERN> 
(assert true)
(define-const var3305 var491 (matcher/468719934 var2733 (cast-from-String-to-String var2585))) ; Statement: r47 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46) 
(assert true)
(define-const var1380 Bool (find/1809080823 var3305)) ; Statement: $z0 = virtualinvoke r47.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z0 == 0 goto r48 = "" 
(assert (= (ite var1380 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1698 String "") ; Statement: r48 = "" 
(assert true) ; Non Conditional
(define-const var1717 var3177 var278-CLASS_PATTERN) ; Statement: $r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN> 
(assert true)
(define-const var1273 var491 (matcher/468719934 var1717 (cast-from-String-to-String var2585))) ; Statement: $r19 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46) 
(assert true)
(define-const var2218 Bool (find/1809080823 var1273)) ; Statement: $z1 = virtualinvoke $r19.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z1 == 0 goto $r2 = new java.lang.IllegalArgumentException 
(assert (= (ite var2218 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2035 var160 var160-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var2544 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2544)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2544!1 String)
(assert (= var2544!1 ""))
(assert true)
(define-const var3953 String (append/672562846 var2544!1 "No such class name in ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such class name in ") 
(declare-const var2544!2 String)
(assert (= var2544!2 (str.++ var2544!1 "No such class name in ")))
(assert true)
(define-const var1817 String (append/672562846 var3953 var2585)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r46) 
(declare-const var3953!1 String)
(assert (= var3953!1 (str.++ var3953 var2585)))
(assert true)
(define-const var576 String (toString/-2075883882 var1817)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2035 var576)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var2035!1 var160)
(declare-const var576!1 String)
 ; Statement: throw $r2 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), find/1809080823=([java.util.regex.Matcher], boolean), var160-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var278=org.apache.dubbo.common.compiler.support.AbstractCompiler, var803=r37, var455=r38, var2300=r45, var1054=null_type, var1357=java.lang.ClassLoader, var1306=r9, var2585=r46, var3177=java.util.regex.Pattern, var2733=$r0, var491=java.util.regex.Matcher, var3305=r47, var1380=$z0, var1698=r48, var1717=$r1, var1273=$r19, var2218=$z1, var160=java.lang.IllegalArgumentException, var2035=$r2, var2544=$r3, var3953=$r4, var1817=$r5, var576=$r6}
; {org.apache.dubbo.common.compiler.support.AbstractCompiler=var278, r37=var803, r38=var455, r45=var2300, null_type=var1054, java.lang.ClassLoader=var1357, r9=var1306, r46=var2585, java.util.regex.Pattern=var3177, $r0=var2733, java.util.regex.Matcher=var491, r47=var3305, $z0=var1380, r48=var1698, $r1=var1717, $r19=var1273, $z1=var2218, java.lang.IllegalArgumentException=var160, $r2=var2035, $r3=var2544, $r4=var3953, $r5=var1817, $r6=var576}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r37 := @this: org.apache.dubbo.common.compiler.support.AbstractCompiler;	r38 := @parameter0: java.lang.Class;	r45 := @parameter1: java.lang.String;	r9 := @parameter2: java.lang.ClassLoader;	r46 = virtualinvoke r45.<java.lang.String: java.lang.String trim()>();	$r0 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern PACKAGE_PATTERN>;	r47 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46);	$z0 = virtualinvoke r47.<java.util.regex.Matcher: boolean find()>();	if $z0 == 0 goto r48 = "";	r48 = "";	$r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN>;	$r19 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46);	$z1 = virtualinvoke $r19.<java.util.regex.Matcher: boolean find()>();	if $z1 == 0 goto $r2 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such class name in ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r46);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 4