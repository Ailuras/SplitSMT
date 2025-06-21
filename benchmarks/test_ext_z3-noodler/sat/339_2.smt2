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

(declare-sort var1732 0)
(declare-sort var2874 0)
(declare-sort var2015 0)
(declare-sort var1886 0)
(declare-sort var1453 0)
(declare-sort var700 0)
(declare-sort var2573 0)
(declare-sort var1809 0)
(declare-sort var486 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var1886_lookupStreamPrintServiceFactories/-1785114605 (var1453 String) (Array Int var1886))
(declare-fun cast-from-var2015-to-var1453 (var2015) var1453)
(declare-fun var1809_toString/-575966009 ((Array Int var486)) String)
(declare-fun cast-from-__Array__Int__var1886__-to-__Array__Int__var486__ ((Array Int var1886)) (Array Int var486))
(declare-fun println/1773605060 (var700 String) void)
(declare-fun getLength-Arr-var1886-1 ((Array Int var1886)) Int)
(declare-const null-var1732 var1732)
(declare-const null-String String)
(declare-const var2015-PRINTABLE var2015)
(declare-const var2573-out var700)
(declare-const var1868 var1732) ; Statement: r7 := @parameter0: javax.swing.JComponent 
(assert (not (= var1868 null-var1732)))
(declare-const var977 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var977 null-String)))
(assert true)
(define-const var2341 Bool (endsWith/985337093 var977 ".ps")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".ps") 
 ; Statement: if $z0 != 0 goto $r16 = <javax.print.DocFlavor$SERVICE_FORMATTED: javax.print.DocFlavor$SERVICE_FORMATTED PRINTABLE> 
(assert (not (= (ite var2341 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2578 var2015 var2015-PRINTABLE) ; Statement: $r16 = <javax.print.DocFlavor$SERVICE_FORMATTED: javax.print.DocFlavor$SERVICE_FORMATTED PRINTABLE> 
(define-const var887 (Array Int var1886) (var1886_lookupStreamPrintServiceFactories/-1785114605 (cast-from-var2015-to-var1453 var2578) "application/postscript")) ; Statement: $r17 = staticinvoke <javax.print.StreamPrintServiceFactory: javax.print.StreamPrintServiceFactory[] lookupStreamPrintServiceFactories(javax.print.DocFlavor,java.lang.String)>($r16, "application/postscript") 
(define-const var3821 var700 var2573-out) ; Statement: $r1 = <java.lang.System: java.io.PrintStream out> 
(define-const var3577 String (var1809_toString/-575966009 (cast-from-__Array__Int__var1886__-to-__Array__Int__var486__ var887))) ; Statement: $r2 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r17) 
(assert true)
;(assert (println/1773605060 var3821 var3577)) ; Statement: virtualinvoke $r1.<java.io.PrintStream: void println(java.lang.String)>($r2) 

(declare-const var3821!1 var700)
(declare-const var3577!1 String)
(define-const var3090 Int (getLength-Arr-var1886-1 var887)) ; Statement: $i0 = lengthof $r17 
 ; Statement: if $i0 <= 0 goto (branch) 
(assert (<= var3090 0)) ; Cond: $i0 <= 0 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var1886_lookupStreamPrintServiceFactories/-1785114605=([javax.print.DocFlavor, java.lang.String], javax.print.StreamPrintServiceFactory[]), cast-from-var2015-to-var1453=([javax.print.DocFlavor$SERVICE_FORMATTED], javax.print.DocFlavor), var1809_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__var1886__-to-__Array__Int__var486__=([javax.print.StreamPrintServiceFactory[]], java.lang.Object[]), println/1773605060=([java.io.PrintStream, java.lang.String], void), getLength-Arr-var1886-1=([javax.print.StreamPrintServiceFactory[]], int)}
; {var1732=javax.swing.JComponent, var1868=r7, var977=r0, var2874=null_type, var2341=$z0, var2015=javax.print.DocFlavor$SERVICE_FORMATTED, var2578=$r16, var1886=javax.print.StreamPrintServiceFactory, var1453=javax.print.DocFlavor, var887=$r17, var700=java.io.PrintStream, var2573=java.lang.System, var3821=$r1, var1809=java.util.Arrays, var486=java.lang.Object, var3577=$r2, var3090=$i0}
; {javax.swing.JComponent=var1732, r7=var1868, r0=var977, null_type=var2874, $z0=var2341, javax.print.DocFlavor$SERVICE_FORMATTED=var2015, $r16=var2578, javax.print.StreamPrintServiceFactory=var1886, javax.print.DocFlavor=var1453, $r17=var887, java.io.PrintStream=var700, java.lang.System=var2573, $r1=var3821, java.util.Arrays=var1809, java.lang.Object=var486, $r2=var3577, $i0=var3090}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r7 := @parameter0: javax.swing.JComponent;	r0 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".ps");	if $z0 != 0 goto $r16 = <javax.print.DocFlavor$SERVICE_FORMATTED: javax.print.DocFlavor$SERVICE_FORMATTED PRINTABLE>;	$r16 = <javax.print.DocFlavor$SERVICE_FORMATTED: javax.print.DocFlavor$SERVICE_FORMATTED PRINTABLE>;	$r17 = staticinvoke <javax.print.StreamPrintServiceFactory: javax.print.StreamPrintServiceFactory[] lookupStreamPrintServiceFactories(javax.print.DocFlavor,java.lang.String)>($r16, "application/postscript");	$r1 = <java.lang.System: java.io.PrintStream out>;	$r2 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r17);	virtualinvoke $r1.<java.io.PrintStream: void println(java.lang.String)>($r2);	$i0 = lengthof $r17;	if $i0 <= 0 goto (branch);	goto [?= return];	return
;block_num 4