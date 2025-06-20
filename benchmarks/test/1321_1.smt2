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

(declare-sort var676 0)
(declare-sort var468 0)
(declare-sort var2226 0)
(declare-sort var1479 0)
(declare-sort var2791 0)
(declare-sort var3782 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun matcher/468719934 (var1479 String) var2791)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun find/1809080823 (var2791) Bool)
(declare-fun group/-653887691 (var2791 Int) String)
(declare-fun var3782-init () var3782)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3782 String) void)
(declare-const null-var676 var676)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var2226 var2226)
(declare-const var676-PACKAGE_PATTERN var1479)
(declare-const var676-CLASS_PATTERN var1479)
(declare-const var120 var676) ; Statement: r37 := @this: org.apache.dubbo.common.compiler.support.AbstractCompiler 
(assert (not (= var120 null-var676)))
(declare-const var3418 ClassObject) ; Statement: r38 := @parameter0: java.lang.Class 
(assert (not (= var3418 null-ClassObject)))
(declare-const var3751 String) ; Statement: r45 := @parameter1: java.lang.String 
(assert (not (= var3751 null-String)))
(declare-const var1413 var2226) ; Statement: r9 := @parameter2: java.lang.ClassLoader 
(assert (not (= var1413 null-var2226)))
(assert true)
(define-const var137 String (trim/-847153721 var3751)) ; Statement: r46 = virtualinvoke r45.<java.lang.String: java.lang.String trim()>() 
(define-const var3708 var1479 var676-PACKAGE_PATTERN) ; Statement: $r0 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern PACKAGE_PATTERN> 
(assert true)
(define-const var1096 var2791 (matcher/468719934 var3708 (cast-from-String-to-String var137))) ; Statement: r47 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46) 
(assert true)
(define-const var2091 Bool (find/1809080823 var1096)) ; Statement: $z0 = virtualinvoke r47.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z0 == 0 goto r48 = "" 
(assert (not (= (ite var2091 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2787 String (group/-653887691 var1096 1)) ; Statement: r48 = virtualinvoke r47.<java.util.regex.Matcher: java.lang.String group(int)>(1) 
 ; Statement: goto [?= $r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN>] 
(assert true) ; Non Conditional
(define-const var1930 var1479 var676-CLASS_PATTERN) ; Statement: $r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN> 
(assert true)
(define-const var1814 var2791 (matcher/468719934 var1930 (cast-from-String-to-String var137))) ; Statement: $r19 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46) 
(assert true)
(define-const var873 Bool (find/1809080823 var1814)) ; Statement: $z1 = virtualinvoke $r19.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z1 == 0 goto $r2 = new java.lang.IllegalArgumentException 
(assert (= (ite var873 1 0) 0)) ; Cond: $z1 == 0 
(define-const var251 var3782 var3782-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var1277 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1277)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1277!1 String)
(assert (= var1277!1 ""))
(assert true)
(define-const var2329 String (append/672562846 var1277!1 "No such class name in ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such class name in ") 
(declare-const var1277!2 String)
(assert (= var1277!2 (str.++ var1277!1 "No such class name in ")))
(assert true)
(define-const var2163 String (append/672562846 var2329 var137)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r46) 
(declare-const var2329!1 String)
(assert (= var2329!1 (str.++ var2329 var137)))
(assert true)
(define-const var2883 String (toString/-2075883882 var2163)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var251 var2883)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var251!1 var3782)
(declare-const var2883!1 String)
 ; Statement: throw $r2 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), find/1809080823=([java.util.regex.Matcher], boolean), group/-653887691=([java.util.regex.Matcher, int], java.lang.String), var3782-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var676=org.apache.dubbo.common.compiler.support.AbstractCompiler, var120=r37, var3418=r38, var3751=r45, var468=null_type, var2226=java.lang.ClassLoader, var1413=r9, var137=r46, var1479=java.util.regex.Pattern, var3708=$r0, var2791=java.util.regex.Matcher, var1096=r47, var2091=$z0, var2787=r48, var1930=$r1, var1814=$r19, var873=$z1, var3782=java.lang.IllegalArgumentException, var251=$r2, var1277=$r3, var2329=$r4, var2163=$r5, var2883=$r6}
; {org.apache.dubbo.common.compiler.support.AbstractCompiler=var676, r37=var120, r38=var3418, r45=var3751, null_type=var468, java.lang.ClassLoader=var2226, r9=var1413, r46=var137, java.util.regex.Pattern=var1479, $r0=var3708, java.util.regex.Matcher=var2791, r47=var1096, $z0=var2091, r48=var2787, $r1=var1930, $r19=var1814, $z1=var873, java.lang.IllegalArgumentException=var3782, $r2=var251, $r3=var1277, $r4=var2329, $r5=var2163, $r6=var2883}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r37 := @this: org.apache.dubbo.common.compiler.support.AbstractCompiler;	r38 := @parameter0: java.lang.Class;	r45 := @parameter1: java.lang.String;	r9 := @parameter2: java.lang.ClassLoader;	r46 = virtualinvoke r45.<java.lang.String: java.lang.String trim()>();	$r0 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern PACKAGE_PATTERN>;	r47 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46);	$z0 = virtualinvoke r47.<java.util.regex.Matcher: boolean find()>();	if $z0 == 0 goto r48 = "";	r48 = virtualinvoke r47.<java.util.regex.Matcher: java.lang.String group(int)>(1);	goto [?= $r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN>];	$r1 = <org.apache.dubbo.common.compiler.support.AbstractCompiler: java.util.regex.Pattern CLASS_PATTERN>;	$r19 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r46);	$z1 = virtualinvoke $r19.<java.util.regex.Matcher: boolean find()>();	if $z1 == 0 goto $r2 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such class name in ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r46);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 4