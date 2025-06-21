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

(declare-sort var191 0)
(declare-sort var3247 0)
(declare-sort var1962 0)
(declare-sort var481 0)
(declare-sort var1275 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun println/-1226480079 (var1962 String) void)
(declare-fun menus/-1591418477 (var191) var1275)
(declare-fun var1275_iterator/-912451715 (var1275) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1275_size/-959786421 (var1275) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var191 var191)
(declare-const null-var3247 var3247)
(declare-const null-var1962 var1962)
(declare-const null-String String)
(declare-const var1800 var191) ; Statement: r1 := @this: com.alibaba.dubbo.container.page.PageServlet 
(assert (not (= var1800 null-var191)))
(declare-const var3224 var3247) ; Statement: r26 := @parameter0: javax.servlet.http.HttpServletRequest 
(assert (not (= var3224 null-var3247)))
(declare-const var3961 var1962) ; Statement: r0 := @parameter1: java.io.PrintWriter 
(assert (not (= var3961 null-var1962)))
(declare-const var1121 String) ; Statement: r10 := @parameter2: java.lang.String 
(assert (not (= var1121 null-String)))
(assert true)
;(assert (println/-1226480079 var3961 "<table>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<table>") 

(declare-const var3961!1 var1962)
(declare-const var1894 String)
(assert true)
;(assert (println/-1226480079 var3961!1 "<thead>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<thead>") 

(declare-const var3961!2 var1962)
(declare-const var537 String)
(assert true)
;(assert (println/-1226480079 var3961!2 "    <tr>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>") 

(declare-const var3961!3 var1962)
(declare-const var1564 String)
(define-const var3373 var1275 (menus/-1591418477 var1800)) ; Statement: $r2 = r1.<com.alibaba.dubbo.container.page.PageServlet: java.util.List menus> 
(define-const var1594 Iterator (var1275_iterator/-912451715 var3373)) ; Statement: r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1963 Bool (Iterator_hasNext/-1669924200 var1594)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>") 
(assert (= (ite var1963 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (println/-1226480079 var3961!3 "    </tr>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>") 

(declare-const var3961!4 var1962)
(declare-const var1010 String)
(assert true)
;(assert (println/-1226480079 var3961!4 "</thead>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</thead>") 

(declare-const var3961!5 var1962)
(declare-const var1155 String)
(assert true)
;(assert (println/-1226480079 var3961!5 "<tbody>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<tbody>") 

(declare-const var3961!6 var1962)
(declare-const var2681 String)
(assert true)
;(assert (println/-1226480079 var3961!6 "    <tr>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>") 

(declare-const var3961!7 var1962)
(declare-const var1564!1 String)
(define-const var1473 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1473)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1473!1 String)
(assert (= var1473!1 ""))
(assert true)
(define-const var3455 String (append/672562846 var1473!1 "        <td style=\u0022text-align: left\u0022 colspan=\u0022")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <td style=\"text-align: left\" colspan=\"") 
(declare-const var1473!2 String)
(assert (= var1473!2 (str.++ var1473!1 "        <td style=\u0022text-align: left\u0022 colspan=\u0022")))
(define-const var3608 var1275 (menus/-1591418477 var1800)) ; Statement: $r5 = r1.<com.alibaba.dubbo.container.page.PageServlet: java.util.List menus> 
(define-const var3636 Int (var1275_size/-959786421 var3608)) ; Statement: $i0 = interfaceinvoke $r5.<java.util.List: int size()>() 
(assert true)
(define-const var2323 String (append/-1001720160 var3455 var3636)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3455!1 String)
(assert (str.prefixof var3455 var3455!1))
(assert true)
(define-const var2210 String (append/672562846 var2323 "\u0022>")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">") 
(declare-const var2323!1 String)
(assert (= var2323!1 (str.++ var2323 "\u0022>")))
(assert true)
(define-const var1362 String (toString/-2075883882 var2210)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/-1226480079 var3961!7 var1362)) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>($r9) 

(declare-const var3961!8 var1962)
(declare-const var1362!1 String)
(assert true)
;(assert (println/-1226480079 var3961!8 var1121)) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>(r10) 

(declare-const var3961!9 var1962)
(declare-const var1121!1 String)
(assert true)
;(assert (println/-1226480079 var3961!9 "        </td>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("        </td>") 

(declare-const var3961!10 var1962)
(declare-const var3044 String)
(assert true)
;(assert (println/-1226480079 var3961!10 "    </tr>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>") 

(declare-const var3961!11 var1962)
(declare-const var1010!1 String)
(assert true)
;(assert (println/-1226480079 var3961!11 "</tbody>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</tbody>") 

(declare-const var3961!12 var1962)
(declare-const var116 String)
(assert true)
;(assert (println/-1226480079 var3961!12 "</table>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</table>") 

(declare-const var3961!13 var1962)
(declare-const var3803 String)
(assert true)
;(assert (println/-1226480079 var3961!13 "<br/>")) ; Statement: virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<br/>") 

(declare-const var3961!14 var1962)
(declare-const var1287 String)
 ; Statement: return 
(check-sat)
; {println/-1226480079=([java.io.PrintWriter, java.lang.String], void), menus/-1591418477=([com.alibaba.dubbo.container.page.PageServlet], java.util.List), var1275_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1275_size/-959786421=([java.util.List], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var191=com.alibaba.dubbo.container.page.PageServlet, var1800=r1, var3247=javax.servlet.http.HttpServletRequest, var3224=r26, var1962=java.io.PrintWriter, var3961=r0, var1121=r10, var481=null_type, var1894="<table>", var537="<thead>", var1564="    <tr>", var1275=java.util.List, var3373=$r2, var1594=r3, var1963=$z0, var1010="    </tr>", var1155="</thead>", var2681="<tbody>", var1473=$r4, var3455=$r6, var3608=$r5, var3636=$i0, var2323=$r7, var2210=$r8, var1362=$r9, var3044="        </td>", var116="</tbody>", var3803="</table>", var1287="<br/>"}
; {com.alibaba.dubbo.container.page.PageServlet=var191, r1=var1800, javax.servlet.http.HttpServletRequest=var3247, r26=var3224, java.io.PrintWriter=var1962, r0=var3961, r10=var1121, null_type=var481, "<table>"=var1894, "<thead>"=var537, "    <tr>"=var1564, java.util.List=var1275, $r2=var3373, r3=var1594, $z0=var1963, "    </tr>"=var1010, "</thead>"=var1155, "<tbody>"=var2681, $r4=var1473, $r6=var3455, $r5=var3608, $i0=var3636, $r7=var2323, $r8=var2210, $r9=var1362, "        </td>"=var3044, "</tbody>"=var116, "</table>"=var3803, "<br/>"=var1287}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: com.alibaba.dubbo.container.page.PageServlet;	r26 := @parameter0: javax.servlet.http.HttpServletRequest;	r0 := @parameter1: java.io.PrintWriter;	r10 := @parameter2: java.lang.String;	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<table>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<thead>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>");	$r2 = r1.<com.alibaba.dubbo.container.page.PageServlet: java.util.List menus>;	r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</thead>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<tbody>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    <tr>");	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("        <td style=\"text-align: left\" colspan=\"");	$r5 = r1.<com.alibaba.dubbo.container.page.PageServlet: java.util.List menus>;	$i0 = interfaceinvoke $r5.<java.util.List: int size()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>($r9);	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>(r10);	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("        </td>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("    </tr>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</tbody>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("</table>");	virtualinvoke r0.<java.io.PrintWriter: void println(java.lang.String)>("<br/>");	return
;block_num 3