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

(declare-sort var1266 0)
(declare-sort var591 0)
(declare-sort var959 0)
(declare-sort var2735 0)
(declare-sort var932 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun random/-1591418477 (var1266) var932)
(declare-fun nextInt/1923127319 (var932) Int)
(declare-fun var2735_size/-959786421 (var2735) Int)
(declare-fun println/-1226480079 (var591 String) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1266 var1266)
(declare-const null-var591 var591)
(declare-const null-String String)
(declare-const null-var2735 var2735)
(declare-const var716 var1266) ; Statement: r0 := @this: com.alibaba.dubbo.container.page.PageServlet 
(assert (not (= var716 null-var1266)))
(declare-const var3305 var591) ; Statement: r4 := @parameter0: java.io.PrintWriter 
(assert (not (= var3305 null-var591)))
(declare-const var3176 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var3176 null-String)))
(declare-const var1165 var2735) ; Statement: r2 := @parameter2: java.util.List 
(assert (not (= var1165 null-var2735)))
(declare-const var2974 var2735) ; Statement: r3 := @parameter3: java.util.List 
(assert (not (= var2974 null-var2735)))
(define-const var953 var932 (random/-1591418477 var716)) ; Statement: $r1 = r0.<com.alibaba.dubbo.container.page.PageServlet: java.util.Random random> 
(assert true)
(define-const var3218 Int (nextInt/1923127319 var953)) ; Statement: i0 = virtualinvoke $r1.<java.util.Random: int nextInt()>() 
 ; Statement: if r2 != null goto $i8 = interfaceinvoke r2.<java.util.List: int size()>() 
(assert (not (= var1165 null-var2735))) ; Cond: r2 != null 
(define-const var1874 Int (var2735_size/-959786421 var1165)) ; Statement: $i8 = interfaceinvoke r2.<java.util.List: int size()>() 
(assert true) ; Non Conditional
(define-const var2607 Int var1874) ; Statement: i1 = $i8 
 ; Statement: if r3 != null goto $i9 = interfaceinvoke r3.<java.util.List: int size()>() 
(assert (not (= var2974 null-var2735))) ; Cond: r3 != null 
(define-const var1290 Int (var2735_size/-959786421 var2974)) ; Statement: $i9 = interfaceinvoke r3.<java.util.List: int size()>() 
(assert true) ; Non Conditional
(define-const var2920 Int var1290) ; Statement: i2 = $i9 
(assert true)
;(assert (println/-1226480079 var3305 "<table>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<table>") 

(declare-const var3305!1 var591)
(declare-const var2257 String)
(assert true)
;(assert (println/-1226480079 var3305!1 "<thead>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<thead>") 

(declare-const var3305!2 var591)
(declare-const var2159 String)
(assert true)
;(assert (println/-1226480079 var3305!2 "    <tr>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>") 

(declare-const var3305!3 var591)
(declare-const var1627 String)
(define-const var1158 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1158)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1158!1 String)
(assert (= var1158!1 ""))
(assert true)
(define-const var2588 String (append/672562846 var1158!1 "        <th colspan=\u0022")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <th colspan=\"") 
(declare-const var1158!2 String)
(assert (= var1158!2 (str.++ var1158!1 "        <th colspan=\u0022")))
(assert true)
(define-const var2342 String (append/-1001720160 var2588 var2607)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var2588!1 String)
(assert (str.prefixof var2588 var2588!1))
(assert true)
(define-const var2730 String (append/672562846 var2342 "\u0022>")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">") 
(declare-const var2342!1 String)
(assert (= var2342!1 (str.++ var2342 "\u0022>")))
(assert true)
(define-const var3190 String (append/672562846 var2730 var3176)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var2730!1 String)
(assert (= var2730!1 (str.++ var2730 var3176)))
(assert true)
(define-const var1653 String (append/672562846 var3190 "</th>")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</th>") 
(declare-const var3190!1 String)
(assert (= var3190!1 (str.++ var3190 "</th>")))
(assert true)
(define-const var1407 String (toString/-2075883882 var1653)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/-1226480079 var3305!3 var1407)) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>($r12) 

(declare-const var3305!4 var591)
(declare-const var1407!1 String)
(assert true)
;(assert (println/-1226480079 var3305!4 "    </tr>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>") 

(declare-const var3305!5 var591)
(declare-const var435 String)
 ; Statement: if r2 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>") 
(assert (= var1165 null-var2735)) ; Cond: r2 == null 
(assert true)
;(assert (println/-1226480079 var3305!5 "</thead>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>") 

(declare-const var3305!6 var591)
(declare-const var1515 String)
 ; Statement: if r3 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>") 
(assert (= var2974 null-var2735)) ; Cond: r3 == null 
(assert true)
;(assert (println/-1226480079 var3305!6 "</table>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>") 

(declare-const var3305!7 var591)
(declare-const var696 String)
(assert true)
;(assert (println/-1226480079 var3305!7 "<br/>")) ; Statement: virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<br/>") 

(declare-const var3305!8 var591)
(declare-const var823 String)
 ; Statement: return 
(check-sat)
; {random/-1591418477=([com.alibaba.dubbo.container.page.PageServlet], java.util.Random), nextInt/1923127319=([java.util.Random], int), var2735_size/-959786421=([java.util.List], int), println/-1226480079=([java.io.PrintWriter, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1266=com.alibaba.dubbo.container.page.PageServlet, var716=r0, var591=java.io.PrintWriter, var3305=r4, var3176=r8, var959=null_type, var2735=java.util.List, var1165=r2, var2974=r3, var932=java.util.Random, var953=$r1, var3218=i0, var1874=$i8, var2607=i1, var1290=$i9, var2920=i2, var2257="<table>", var2159="<thead>", var1627="    <tr>", var1158=$r5, var2588=$r6, var2342=$r7, var2730=$r9, var3190=$r10, var1653=$r11, var1407=$r12, var435="    </tr>", var1515="</thead>", var696="</table>", var823="<br/>"}
; {com.alibaba.dubbo.container.page.PageServlet=var1266, r0=var716, java.io.PrintWriter=var591, r4=var3305, r8=var3176, null_type=var959, java.util.List=var2735, r2=var1165, r3=var2974, java.util.Random=var932, $r1=var953, i0=var3218, $i8=var1874, i1=var2607, $i9=var1290, i2=var2920, "<table>"=var2257, "<thead>"=var2159, "    <tr>"=var1627, $r5=var1158, $r6=var2588, $r7=var2342, $r9=var2730, $r10=var3190, $r11=var1653, $r12=var1407, "    </tr>"=var435, "</thead>"=var1515, "</table>"=var696, "<br/>"=var823}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: com.alibaba.dubbo.container.page.PageServlet;	r4 := @parameter0: java.io.PrintWriter;	r8 := @parameter1: java.lang.String;	r2 := @parameter2: java.util.List;	r3 := @parameter3: java.util.List;	$r1 = r0.<com.alibaba.dubbo.container.page.PageServlet: java.util.Random random>;	i0 = virtualinvoke $r1.<java.util.Random: int nextInt()>();	if r2 != null goto $i8 = interfaceinvoke r2.<java.util.List: int size()>();	$i8 = interfaceinvoke r2.<java.util.List: int size()>();	i1 = $i8;	if r3 != null goto $i9 = interfaceinvoke r3.<java.util.List: int size()>();	$i9 = interfaceinvoke r3.<java.util.List: int size()>();	i2 = $i9;	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<thead>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>");	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <th colspan=\"");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</th>");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>($r12);	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>");	if r2 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</thead>");	if r3 == null goto virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("</table>");	virtualinvoke r4.<java.io.PrintWriter: void println(java.lang.String)>("<br/>");	return
;block_num 7