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

(declare-sort var3973 0)
(declare-sort var1767 0)
(declare-sort var2099 0)
(declare-sort var3738 0)
(declare-sort var490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun errMgr/-858771875 (var3973) var2099)
(declare-fun arr-var490-init () (Array Int var490))
(declare-fun cast-from-String-to-var490 (String) var490)
(declare-fun toolError/-1606759567 (var2099 var3738 (Array Int var490)) void)
(declare-const null-var3973 var3973)
(declare-const null-String String)
(declare-const var3738-BAD_OPTION_SET_SYNTAX var3738)
(declare-const null-__Array__Int__var490__ (Array Int var490))
(declare-const var1838 var3973) ; Statement: r1 := @this: org.antlr.v4.Tool 
(assert (not (= var1838 null-var3973)))
(declare-const var2876 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2876 null-String)))
(assert true)
(define-const var3567 Int (indexOf/-1037706067 var2876 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
 ; Statement: if i0 <= 0 goto $r4 = r1.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr> 
(assert (<= var3567 0)) ; Cond: i0 <= 0 
(define-const var3396 var2099 (errMgr/-858771875 var1838)) ; Statement: $r4 = r1.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr> 
(define-const var694 var3738 var3738-BAD_OPTION_SET_SYNTAX) ; Statement: $r3 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType BAD_OPTION_SET_SYNTAX> 
(define-const var847 (Array Int var490) arr-var490-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(declare-const var847!1 (Array Int var490))
(assert (not (= var847!1 null-__Array__Int__var490__)))
(assert (= (select var847!1 0) (cast-from-String-to-var490 var2876))) ; Statement: $r2[0] = r0 
(assert true)
;(assert (toolError/-1606759567 var3396 var694 var847!1)) ; Statement: virtualinvoke $r4.<org.antlr.v4.tool.ErrorManager: void toolError(org.antlr.v4.tool.ErrorType,java.lang.Object[])>($r3, $r2) 

(declare-const var3396!1 var2099)
(declare-const var694!1 var3738)
(declare-const var847!2 (Array Int var490))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), errMgr/-858771875=([org.antlr.v4.Tool], org.antlr.v4.tool.ErrorManager), arr-var490-init=([], java.lang.Object[]), cast-from-String-to-var490=([java.lang.String], java.lang.Object), toolError/-1606759567=([org.antlr.v4.tool.ErrorManager, org.antlr.v4.tool.ErrorType, java.lang.Object[]], void)}
; {var3973=org.antlr.v4.Tool, var1838=r1, var2876=r0, var1767=null_type, var3567=i0, var2099=org.antlr.v4.tool.ErrorManager, var3396=$r4, var3738=org.antlr.v4.tool.ErrorType, var694=$r3, var490=java.lang.Object, var847=$r2}
; {org.antlr.v4.Tool=var3973, r1=var1838, r0=var2876, null_type=var1767, i0=var3567, org.antlr.v4.tool.ErrorManager=var2099, $r4=var3396, org.antlr.v4.tool.ErrorType=var3738, $r3=var694, java.lang.Object=var490, $r2=var847}
;seq <java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1}
;stmts r1 := @this: org.antlr.v4.Tool;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	if i0 <= 0 goto $r4 = r1.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr>;	$r4 = r1.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr>;	$r3 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType BAD_OPTION_SET_SYNTAX>;	$r2 = newarray (java.lang.Object)[1];	$r2[0] = r0;	virtualinvoke $r4.<org.antlr.v4.tool.ErrorManager: void toolError(org.antlr.v4.tool.ErrorType,java.lang.Object[])>($r3, $r2);	return
;block_num 3