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

(declare-sort var1459 0)
(declare-sort var859 0)
(declare-sort var3362 0)
(declare-sort var1864 0)
(declare-sort var3140 0)
(declare-sort var280 0)
(declare-sort var2960 0)
(declare-sort var2307 0)
(declare-sort var2595 0)
(declare-sort var3792 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3362_isAttrStorageEmpty/-1529149563 (var3362) Bool)
(declare-fun var1864_of/184955601 ((Array Int var3140)) var1864)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3140__ ((Array Int String)) (Array Int var3140))
(declare-fun var2960_bootstrap$/-393957991 () var280)
(declare-fun var1864_filter/320182972 (var1864 var280) var1864)
(declare-fun var2595_toList/714215649 () var2307)
(declare-fun var1864_collect/-2050842585 (var1864 var2307) var3140)
(declare-fun cast-from-var3140-to-var3792 (var3140) var3792)
(declare-fun var3792_iterator/-912451715 (var3792) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var1459 var1459)
(declare-const null-String String)
(declare-const null-var3362 var3362)
(declare-const var995 var1459) ; Statement: r9 := @parameter0: jadx.api.ICodeWriter 
(assert (not (= var995 null-var1459)))
(declare-const var3611 String) ; Statement: r10 := @parameter1: java.lang.String 
(assert (not (= var3611 null-String)))
(declare-const var877 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var877 null-String)))
(declare-const var868 var3362) ; Statement: r0 := @parameter3: jadx.core.dex.attributes.IAttributeNode 
(assert (not (= var868 null-var3362)))
(define-const var2377 Bool (var3362_isAttrStorageEmpty/-1529149563 var868)) ; Statement: $z0 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: boolean isAttrStorageEmpty()>() 
 ; Statement: if $z0 == 0 goto $r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>() 
(assert (not (= (ite var2377 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var496 String var877) ; Statement: $r20 = r1 
 ; Statement: goto [?= $r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R")] 
(assert true) ; Non Conditional
; split operation: var1543 = var496.split("\u005cR") ; Statement: $r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R") 
(define-const var897 var1864 (var1864_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var3140__ var1543))) ; Statement: $r5 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r3) 
(define-const var13 var280 var2960_bootstrap$/-393957991) ; Statement: $r4 = staticinvoke <jadx.core.utils.DebugUtils$notBlank__492: java.util.function.Predicate bootstrap$()>() 
(define-const var666 var1864 (var1864_filter/320182972 var897 var13)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4) 
(define-const var461 var2307 var2595_toList/714215649) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var1961 var3140 (var1864_collect/-2050842585 var666 var461)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var2074 var3792 (cast-from-var3140-to-var3792 var1961)) ; Statement: $r18 = (java.util.List) $r8 
(define-const var1804 Iterator (var3792_iterator/-912451715 var2074)) ; Statement: $r19 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>() 
(define-const var3233 Bool (Iterator_hasNext/-1669924200 var1804)) ; Statement: $z1 = interfaceinvoke $r19.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 != 0 goto $r13 = interfaceinvoke r9.<jadx.api.ICodeWriter: jadx.api.ICodeWriter startLine(java.lang.String)>(r10) 
(assert (not (not (= (ite var3233 1 0) 0)))) ; Negate: Cond: $z1 != 0  
 ; Statement: return 
(check-sat)
; {var3362_isAttrStorageEmpty/-1529149563=([jadx.core.dex.attributes.IAttributeNode], boolean), var1864_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var3140__=([java.lang.String[]], java.lang.Object[]), var2960_bootstrap$/-393957991=([], java.util.function.Predicate), var1864_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2595_toList/714215649=([], java.util.stream.Collector), var1864_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3140-to-var3792=([java.lang.Object], java.util.List), var3792_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1459=jadx.api.ICodeWriter, var995=r9, var3611=r10, var859=null_type, var877=r1, var3362=jadx.core.dex.attributes.IAttributeNode, var868=r0, var2377=$z0, var496=$r20, var1543=$r3, var1864=java.util.stream.Stream, var3140=java.lang.Object, var897=$r5, var280=java.util.function.Predicate, var2960=jadx.core.utils.DebugUtils$notBlank__492, var13=$r4, var666=$r7, var2307=java.util.stream.Collector, var2595=java.util.stream.Collectors, var461=$r6, var1961=$r8, var3792=java.util.List, var2074=$r18, var1804=$r19, var3233=$z1}
; {jadx.api.ICodeWriter=var1459, r9=var995, r10=var3611, null_type=var859, r1=var877, jadx.core.dex.attributes.IAttributeNode=var3362, r0=var868, $z0=var2377, $r20=var496, $r3=var1543, java.util.stream.Stream=var1864, java.lang.Object=var3140, $r5=var897, java.util.function.Predicate=var280, jadx.core.utils.DebugUtils$notBlank__492=var2960, $r4=var13, $r7=var666, java.util.stream.Collector=var2307, java.util.stream.Collectors=var2595, $r6=var461, $r8=var1961, java.util.List=var3792, $r18=var2074, $r19=var1804, $z1=var3233}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r9 := @parameter0: jadx.api.ICodeWriter;	r10 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	r0 := @parameter3: jadx.core.dex.attributes.IAttributeNode;	$z0 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: boolean isAttrStorageEmpty()>();	if $z0 == 0 goto $r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>();	$r20 = r1;	goto [?= $r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R")];	$r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R");	$r5 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r3);	$r4 = staticinvoke <jadx.core.utils.DebugUtils$notBlank__492: java.util.function.Predicate bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4);	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r18 = (java.util.List) $r8;	$r19 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke $r19.<java.util.Iterator: boolean hasNext()>();	if $z1 != 0 goto $r13 = interfaceinvoke r9.<jadx.api.ICodeWriter: jadx.api.ICodeWriter startLine(java.lang.String)>(r10);	return
;block_num 4