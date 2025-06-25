(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1251 0)
(declare-sort var3740 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-39316736 (var1251 (Array Int String)) void)
(declare-const null-var1251 var1251)
(declare-const null-String String)
(declare-const var2528 var1251) ; Statement: r0 := @this: kong.unirest.core.Cookie 
(assert (not (= var2528 null-var1251)))
(declare-const var1893 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1893 null-String)))
; split operation: var3207 = var1893.split(";") ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(assert true)
;(assert (<init>/-39316736 var2528 var3207)) ; Statement: specialinvoke r0.<kong.unirest.core.Cookie: void <init>(java.lang.String[])>($r2) 

(declare-const var2528!1 var1251)
(declare-const var3207!1 (Array Int String))
 ; Statement: return 
(check-sat)
; {<init>/-39316736=([kong.unirest.core.Cookie, java.lang.String[]], void)}
; {var1251=kong.unirest.core.Cookie, var2528=r0, var1893=r1, var3740=null_type, var3207=$r2}
; {kong.unirest.core.Cookie=var1251, r0=var2528, r1=var1893, null_type=var3740, $r2=var3207}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: kong.unirest.core.Cookie;	r1 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	specialinvoke r0.<kong.unirest.core.Cookie: void <init>(java.lang.String[])>($r2);	return
;block_num 1