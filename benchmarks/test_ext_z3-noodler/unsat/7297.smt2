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

(declare-sort var3661 0)
(declare-sort var2521 0)
(declare-sort var2541 0)
(declare-sort var817 0)
(declare-sort var3912 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun random/-1591418477 (var3661) var3912)
(declare-fun nextInt/1923127319 (var3912) Int)
(declare-fun var817_size/-959786421 (var817) Int)
(declare-fun println/-1226480079 (var2521 String) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3661 var3661)
(declare-const null-var2521 var2521)
(declare-const null-String String)
(declare-const null-var817 var817)
(declare-const var3423 var3661) ; Statement: r0 := @this: com.alibaba.dubbo.container.page.PageServlet 
(assert (not (= var3423 null-var3661)))
(declare-const var2362 var2521) ; Statement: r4 := @parameter0: java.io.PrintWriter 
(assert (not (= var2362 null-var2521)))
(declare-const var3867 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var3867 null-String)))
(declare-const var745 var817) ; Statement: r2 := @parameter2: java.util.List 
(assert (not (= var745 null-var817)))
(declare-const var1315 var817) ; Statement: r3 := @parameter3: java.util.List 
(assert (not (= var1315 null-var817)))
(define-const var3861 var3912 (random/-1591418477 var3423)) ; Statement: $r1 = r0.<com.alibaba.dubbo.container.page.PageServlet: java.util.Random random> 
(assert true)
(define-const var3210 Int (nextInt/1923127319 var3861)) ; Statement: i0 = virtualinvoke $r1.<java.util.Random: int nextInt()>() 
 ; Statement: if r2 != null goto $i8 = interfaceinvoke r2.<java.util.List: int size()>() 
(assert (not (= var745 null-var817))) ; Cond: r2 != null 
(define-const var3008 Int (var817_size/-959786421 var745)) ; Statement: $i8 = interfaceinvoke r2.<java.util.List: int size()>() 
(assert true) ; Non Conditional
(define-const var410 Int var3008) ; Statement: i1 = $i8 
 ; Statement: if r3 != null goto $i9 = interfaceinvoke r3.<java.util.List: int size()>() 
(assert (not (not (= var1315 null-var817)))) ; Negate: Cond: r3 != null  
(define-const var1073 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= i2 = $i9] 
(assert true) ; Non Conditional
(define-const var2671 Int var1073) ; Statement: i2 = $i9 
(assert true)
;(assert (println/-1226480079 var2362 "<table>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<table>") 

(declare-const var2362!1 var2521)
(declare-const var248 String)
(assert true)
;(assert (println/-1226480079 var2362!1 "<thead>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<thead>") 

(declare-const var2362!2 var2521)
(declare-const var3130 String)
(assert true)
;(assert (println/-1226480079 var2362!2 "    <tr>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>") 

(declare-const var2362!3 var2521)
(declare-const var571 String)
(define-const var2440 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2440)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2440!1 String)
(assert (= var2440!1 ""))
(assert true)
(define-const var705 String (append/672562846 var2440!1 "        <th colspan=\u0022")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <th colspan=\"") 
(declare-const var2440!2 String)
(assert (= var2440!2 (str.++ var2440!1 "        <th colspan=\u0022")))
(assert true)
(define-const var2373 String (append/-1001720160 var705 var410)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var705!1 String)
(assert (str.prefixof var705 var705!1))
(assert true)
(define-const var2851 String (append/672562846 var2373 "\u0022>")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">") 
(declare-const var2373!1 String)
(assert (= var2373!1 (str.++ var2373 "\u0022>")))
(assert true)
(define-const var1873 String (append/672562846 var2851 var3867)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var2851!1 String)
(assert (= var2851!1 (str.++ var2851 var3867)))
(assert true)
(define-const var2981 String (append/672562846 var1873 "</th>")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</th>") 
(declare-const var1873!1 String)
(assert (= var1873!1 (str.++ var1873 "</th>")))
(assert true)
(define-const var2074 String (toString/-2075883882 var2981)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/-1226480079 var2362!3 var2074)) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>($r12) 

(declare-const var2362!4 var2521)
(declare-const var2074!1 String)
(assert true)
;(assert (println/-1226480079 var2362!4 "    </tr>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>") 

(declare-const var2362!5 var2521)
(declare-const var189 String)
 ; Statement: if r2 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>") 
(assert (= var745 null-var817)) ; Cond: r2 == null 
(assert true)
;(assert (println/-1226480079 var2362!5 "</thead>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>") 

(declare-const var2362!6 var2521)
(declare-const var3842 String)
 ; Statement: if r3 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>") 
(assert (= var1315 null-var817)) ; Cond: r3 == null 
(assert true)
;(assert (println/-1226480079 var2362!6 "</table>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>") 

(declare-const var2362!7 var2521)
(declare-const var3009 String)
(assert true)
;(assert (println/-1226480079 var2362!7 "<br/>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<br/>") 

(declare-const var2362!8 var2521)
(declare-const var3554 String)
 ; Statement: return 
(check-sat)
; {random/-1591418477=([com.alibaba.dubbo.container.page.PageServlet], java.util.Random), nextInt/1923127319=([java.util.Random], int), var817_size/-959786421=([java.util.List], int), println/-1226480079=([java.io.PrintWriter, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3661=com.alibaba.dubbo.container.page.PageServlet, var3423=r0, var2521=java.io.PrintWriter, var2362=r4, var3867=r8, var2541=null_type, var817=java.util.List, var745=r2, var1315=r3, var3912=java.util.Random, var3861=$r1, var3210=i0, var3008=$i8, var410=i1, var1073=$i9, var2671=i2, var248="<table>", var3130="<thead>", var571="    <tr>", var2440=$r5, var705=$r6, var2373=$r7, var2851=$r9, var1873=$r10, var2981=$r11, var2074=$r12, var189="    </tr>", var3842="</thead>", var3009="</table>", var3554="<br/>"}
; {com.alibaba.dubbo.container.page.PageServlet=var3661, r0=var3423, java.io.PrintWriter=var2521, r4=var2362, r8=var3867, null_type=var2541, java.util.List=var817, r2=var745, r3=var1315, java.util.Random=var3912, $r1=var3861, i0=var3210, $i8=var3008, i1=var410, $i9=var1073, i2=var2671, "<table>"=var248, "<thead>"=var3130, "    <tr>"=var571, $r5=var2440, $r6=var705, $r7=var2373, $r9=var2851, $r10=var1873, $r11=var2981, $r12=var2074, "    </tr>"=var189, "</thead>"=var3842, "</table>"=var3009, "<br/>"=var3554}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: com.alibaba.dubbo.container.page.PageServlet;	r4 := @parameter0: java.io.PrintWriter;	r8 := @parameter1: java.lang.String;	r2 := @parameter2: java.util.List;	r3 := @parameter3: java.util.List;	$r1 = r0.<com.alibaba.dubbo.container.page.PageServlet: java.util.Random random>;	i0 = virtualinvoke $r1.<java.util.Random: int nextInt()>();	if r2 != null goto $i8 = interfaceinvoke r2.<java.util.List: int size()>();	$i8 = interfaceinvoke r2.<java.util.List: int size()>();	i1 = $i8;	if r3 != null goto $i9 = interfaceinvoke r3.<java.util.List: int size()>();	$i9 = 0;	goto [?= i2 = $i9];	i2 = $i9;	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<thead>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>");	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <th colspan=\"");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</th>");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>($r12);	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>");	if r2 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>");	if r3 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<br/>");	return
;block_num 7