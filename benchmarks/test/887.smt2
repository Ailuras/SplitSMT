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

(declare-sort var1200 0)
(declare-sort var2780 0)
(declare-sort var2583 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ps/1203940574 (var1200) String)
(declare-fun arr-var2583-init () (Array Int var2583))
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-fun cast-from-Float64-to-var2583 (Float64) var2583)
(declare-fun String_format/-647569892 (var2780 String (Array Int var2583)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var1200 var1200)
(declare-const null-Float64 Float64)
(declare-const var2780-US var2780)
(declare-const null-__Array__Int__var2583__ (Array Int var2583))
(declare-const var435 var1200) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var435 null-var1200)))
(declare-const var3618 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var3618 null-Float64)))
(declare-const var3334 Float64) ; Statement: d1 := @parameter1: double 
(assert (not (= var3334 null-Float64)))
(declare-const var2063 Float64) ; Statement: d2 := @parameter2: double 
(assert (not (= var2063 null-Float64)))
(declare-const var110 Float64) ; Statement: d3 := @parameter3: double 
(assert (not (= var110 null-Float64)))
(define-const var656 String (ps/1203940574 var435)) ; Statement: $r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(define-const var258 var2780 var2780-US) ; Statement: $r3 = <java.util.Locale: java.util.Locale US> 
(define-const var3510 (Array Int var2583) arr-var2583-init) ; Statement: $r1 = newarray (java.lang.Object)[4] 
(define-const var3736 Float64 (Float64_valueOf/679560954 var3618)) ; Statement: $r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0) 
(declare-const var3510!1 (Array Int var2583))
(assert (not (= var3510!1 null-__Array__Int__var2583__)))
(assert (= (select var3510!1 0) (cast-from-Float64-to-var2583 var3736))) ; Statement: $r1[0] = $r4 
(define-const var2718 Float64 (Float64_valueOf/679560954 var3334)) ; Statement: $r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1) 
(declare-const var3510!2 (Array Int var2583))
(assert (not (= var3510!2 null-__Array__Int__var2583__)))
(assert (= (select var3510!2 1) (cast-from-Float64-to-var2583 var2718))) ; Statement: $r1[1] = $r5 
(define-const var3992 Float64 (Float64_valueOf/679560954 var2063)) ; Statement: $r6 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d2) 
(declare-const var3510!3 (Array Int var2583))
(assert (not (= var3510!3 null-__Array__Int__var2583__)))
(assert (= (select var3510!3 2) (cast-from-Float64-to-var2583 var3992))) ; Statement: $r1[2] = $r6 
(define-const var2752 Float64 (Float64_valueOf/679560954 var110)) ; Statement: $r7 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d3) 
(declare-const var3510!4 (Array Int var2583))
(assert (not (= var3510!4 null-__Array__Int__var2583__)))
(assert (= (select var3510!4 3) (cast-from-Float64-to-var2583 var2752))) ; Statement: $r1[3] = $r7 
(define-const var3266 String (String_format/-647569892 var258 "%1.3f %1.3f %1.3f %1.3f highlight\n" var3510!4)) ; Statement: $r8 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f %1.3f %1.3f highlight\n", $r1) 
(assert true)
;(assert (append/672562846 var656 var3266)) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var656!1 String)
(assert (= var656!1 (str.++ var656 var3266)))
 ; Statement: return 
(check-sat)
; {ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), arr-var2583-init=([], java.lang.Object[]), Float64_valueOf/679560954=([double], java.lang.Double), cast-from-Float64-to-var2583=([java.lang.Double], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1200=org.antlr.v4.gui.PostScriptDocument, var435=r0, var3618=d0, var3334=d1, var2063=d2, var110=d3, var656=$r2, var2780=java.util.Locale, var258=$r3, var2583=java.lang.Object, var3510=$r1, var3736=$r4, var2718=$r5, var3992=$r6, var2752=$r7, var3266=$r8}
; {org.antlr.v4.gui.PostScriptDocument=var1200, r0=var435, d0=var3618, d1=var3334, d2=var2063, d3=var110, $r2=var656, java.util.Locale=var2780, $r3=var258, java.lang.Object=var2583, $r1=var3510, $r4=var3736, $r5=var2718, $r6=var3992, $r7=var2752, $r8=var3266}
;seq <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	d0 := @parameter0: double;	d1 := @parameter1: double;	d2 := @parameter2: double;	d3 := @parameter3: double;	$r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r3 = <java.util.Locale: java.util.Locale US>;	$r1 = newarray (java.lang.Object)[4];	$r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0);	$r1[0] = $r4;	$r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1);	$r1[1] = $r5;	$r6 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d2);	$r1[2] = $r6;	$r7 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d3);	$r1[3] = $r7;	$r8 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f %1.3f %1.3f highlight\n", $r1);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	return
;block_num 1